#!/usr/bin/env bash
#
# update-addon.sh - Script to check and update addon versions
#
# Usage: ./update-addon.sh <addon_dir> [--dry-run]
#
# This script:
# 1. Parses the Dockerfile to find packages with renovate comments
# 2. Queries APIs (Repology/GitHub) for latest versions
# 3. Updates Dockerfile and config.yaml if updates are available
#

set -euo pipefail

ADDON_DIR="${1:-}"
DRY_RUN="${2:-false}"

if [ -z "$ADDON_DIR" ]; then
    echo "Usage: $0 <addon_dir> [--dry-run]"
    exit 1
fi

if [ "$DRY_RUN" = "--dry-run" ]; then
    DRY_RUN=true
fi

ADDON_NAME="${ADDON_DIR%/}"
DOCKERFILE="${ADDON_DIR}/Dockerfile"
CONFIG_FILE="${ADDON_DIR}/config.yaml"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Validate addon directory
if [ ! -f "$DOCKERFILE" ]; then
    log_error "Dockerfile not found: $DOCKERFILE"
    exit 1
fi

if [ ! -f "$CONFIG_FILE" ]; then
    log_error "config.yaml not found: $CONFIG_FILE"
    exit 1
fi

# Function to query Repology API
query_repology() {
    local dep_name="$1"
    local repo="${dep_name%%/*}"
    local pkg="${dep_name##*/}"

    local response
    response=$(curl -sf "https://repology.org/api/v1/project/${pkg}" 2>/dev/null) || {
        log_warn "Failed to query Repology for $pkg"
        echo ""
        return
    }

    # Find version for the specified Alpine repository
    local version
    version=$(echo "$response" | jq -r --arg repo "$repo" '
        [.[] | select(.repo == $repo)] |
        if length > 0 then
            (map(select(.status == "newest")) | if length > 0 then .[0].version else null end) //
            (map(select(.status == "devel")) | if length > 0 then .[0].version else null end) //
            .[0].version
        else
            null
        end
    ' 2>/dev/null)

    if [ "$version" = "null" ] || [ -z "$version" ]; then
        echo ""
    else
        echo "$version"
    fi
}

# Function to query GitHub API for latest release
query_github_release() {
    local dep_name="$1"
    local token="${GITHUB_TOKEN:-}"

    local auth_header=""
    if [ -n "$token" ]; then
        auth_header="-H \"Authorization: token $token\""
    fi

    local response
    response=$(curl -sf ${auth_header:+"$auth_header"} \
        "https://api.github.com/repos/${dep_name}/releases/latest" 2>/dev/null) || {
        log_warn "Failed to query GitHub for $dep_name"
        echo ""
        return
    }

    local version
    version=$(echo "$response" | jq -r '.tag_name // empty' 2>/dev/null)
    echo "$version"
}

# Parse Dockerfile and extract main package info
parse_dockerfile() {
    local datasource=""
    local dep_name=""
    local package_name=""
    local current_version=""
    local found=false

    while IFS= read -r line; do
        # Look for renovate comment
        if [[ "$line" =~ ^#[[:space:]]*renovate:[[:space:]]*datasource=([^[:space:]]+)[[:space:]]+depName=([^[:space:]]+) ]]; then
            datasource="${BASH_REMATCH[1]}"
            dep_name="${BASH_REMATCH[2]}"
            found=true
            continue
        fi

        # If we found a renovate comment, look for the version in subsequent lines
        if [ "$found" = true ]; then
            if [ "$datasource" = "repology" ]; then
                # Match package==version or package=version
                if [[ "$line" =~ ([a-z0-9_-]+)==?([0-9][^[:space:]\\]*) ]]; then
                    package_name="${BASH_REMATCH[1]}"
                    current_version="${BASH_REMATCH[2]}"
                    break
                fi
            elif [ "$datasource" = "github-releases" ]; then
                # Match ARG/ENV with VERSION
                if [[ "$line" =~ ^[[:space:]]*(ARG|ENV)[[:space:]]+[A-Z_]*VERSION=([^[:space:]]+) ]]; then
                    current_version="${BASH_REMATCH[2]}"
                    package_name="${dep_name##*/}"
                    break
                fi
            fi

            # Reset if we hit an unrelated line (not a continuation)
            if [[ ! "$line" =~ \\ ]] && [[ ! "$line" =~ ^[[:space:]]*(RUN|ARG|ENV) ]] && [[ ! "$line" =~ ^[[:space:]]*$ ]]; then
                found=false
            fi
        fi
    done < "$DOCKERFILE"

    echo "${datasource}|${dep_name}|${package_name}|${current_version}"
}

# Calculate new config version based on package version change
calculate_config_version() {
    local current_config_version="$1"
    local old_package_version="$2"
    local new_package_version="$3"

    # Remove 'v' prefix if present
    new_package_version="${new_package_version#v}"
    old_package_version="${old_package_version#v}"

    if [ "$old_package_version" != "$new_package_version" ]; then
        # Package version changed - use new version with -1 suffix
        echo "${new_package_version}-1"
    else
        # Same package version - increment suffix
        if [[ "$current_config_version" =~ ^(.+)-([0-9]+)$ ]]; then
            local base="${BASH_REMATCH[1]}"
            local suffix="${BASH_REMATCH[2]}"
            echo "${base}-$((suffix + 1))"
        else
            # No suffix, add -1
            echo "${current_config_version}-1"
        fi
    fi
}

# Update Dockerfile with new version
update_dockerfile() {
    local package_name="$1"
    local old_version="$2"
    local new_version="$3"
    local datasource="$4"

    if [ "$datasource" = "repology" ]; then
        # Escape special characters for sed
        local old_escaped="${old_version//./\\.}"
        local new_escaped="${new_version}"

        # Update package==version and package=version patterns
        sed -i "s/\(${package_name}\)==${old_escaped}/\1==${new_escaped}/g" "$DOCKERFILE"
        sed -i "s/\(${package_name}\)=${old_escaped}/\1=${new_escaped}/g" "$DOCKERFILE"
    elif [ "$datasource" = "github-releases" ]; then
        sed -i "s/VERSION=${old_version}/VERSION=${new_version}/g" "$DOCKERFILE"
    fi
}

# Update config.yaml version
update_config() {
    local new_version="$1"
    yq eval -i ".version = \"${new_version}\"" "$CONFIG_FILE"
}

# Main execution
main() {
    log_info "Processing addon: $ADDON_NAME"

    # Get current config version
    local current_config_version
    current_config_version=$(yq eval '.version' "$CONFIG_FILE")
    log_info "Current config version: $current_config_version"

    # Parse Dockerfile
    local package_info
    package_info=$(parse_dockerfile)
    IFS='|' read -r datasource dep_name package_name current_version <<< "$package_info"

    if [ -z "$datasource" ] || [ -z "$current_version" ]; then
        log_warn "Could not detect main package info in Dockerfile"
        exit 0
    fi

    log_info "Main package: $package_name"
    log_info "Datasource: $datasource"
    log_info "Current package version: $current_version"

    # Query for latest version
    local latest_version=""
    if [ "$datasource" = "repology" ]; then
        latest_version=$(query_repology "$dep_name")
    elif [ "$datasource" = "github-releases" ]; then
        latest_version=$(query_github_release "$dep_name")
    fi

    if [ -z "$latest_version" ]; then
        log_warn "Could not fetch latest version"
        exit 0
    fi

    log_info "Latest version available: $latest_version"

    # Compare versions
    local current_normalized="${current_version#v}"
    local latest_normalized="${latest_version#v}"

    if [ "$current_normalized" = "$latest_normalized" ]; then
        log_info "Already up to date"
        echo "UP_TO_DATE"
        exit 0
    fi

    log_info "Update available: $current_version -> $latest_version"

    # Calculate new config version
    local new_config_version
    new_config_version=$(calculate_config_version "$current_config_version" "$current_version" "$latest_version")
    log_info "New config version: $new_config_version"

    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would update $ADDON_NAME"
        echo "UPDATE_AVAILABLE|$current_version|$latest_version|$new_config_version"
        exit 0
    fi

    # Apply updates
    log_info "Updating Dockerfile..."
    update_dockerfile "$package_name" "$current_version" "$latest_version" "$datasource"

    log_info "Updating config.yaml..."
    update_config "$new_config_version"

    log_info "Update complete"
    echo "UPDATED|$current_version|$latest_version|$new_config_version"
}

main "$@"
