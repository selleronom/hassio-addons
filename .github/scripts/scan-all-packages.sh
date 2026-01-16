#!/usr/bin/env bash
#
# scan-all-packages.sh - Scan Dockerfile for all packages and check for updates
#
# Usage: ./scan-all-packages.sh <dockerfile> [--update]
#
# This script finds ALL packages with version pins in a Dockerfile and checks
# for updates. It handles both Alpine packages (via Repology) and pinned
# dependencies with versions.
#

set -euo pipefail

DOCKERFILE="${1:-}"
DO_UPDATE="${2:-}"

if [ -z "$DOCKERFILE" ]; then
    echo "Usage: $0 <dockerfile> [--update]"
    exit 1
fi

if [ ! -f "$DOCKERFILE" ]; then
    echo "Error: Dockerfile not found: $DOCKERFILE"
    exit 1
fi

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# Cache for Repology results to avoid duplicate API calls
declare -A REPOLOGY_CACHE

# Query Repology API with caching
query_repology_cached() {
    local pkg="$1"
    local repo="${2:-alpine_edge}"

    local cache_key="${repo}/${pkg}"
    if [[ -v "REPOLOGY_CACHE[$cache_key]" ]]; then
        echo "${REPOLOGY_CACHE[$cache_key]}"
        return
    fi

    local response
    response=$(curl -sf "https://repology.org/api/v1/project/${pkg}" 2>/dev/null) || {
        REPOLOGY_CACHE[$cache_key]=""
        echo ""
        return
    }

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

    if [ "$version" = "null" ]; then
        version=""
    fi

    REPOLOGY_CACHE[$cache_key]="$version"
    echo "$version"
}

# Extract all versioned packages from Dockerfile
extract_packages() {
    local packages=()

    # Find packages with ==version or =version pattern (Alpine packages)
    while IFS= read -r match; do
        if [ -n "$match" ]; then
            # Extract package name and version
            if [[ "$match" =~ ([a-z0-9_-]+)==?([0-9][^[:space:]\\\"\']*) ]]; then
                local pkg="${BASH_REMATCH[1]}"
                local ver="${BASH_REMATCH[2]}"
                packages+=("alpine|$pkg|$ver")
            fi
        fi
    done < <(grep -oE '[a-z0-9_-]+==?[0-9][^[:space:]\\]*' "$DOCKERFILE" 2>/dev/null || true)

    # Find ARG/ENV VERSION patterns (for GitHub releases, etc.)
    while IFS= read -r line; do
        if [[ "$line" =~ (ARG|ENV)[[:space:]]+([A-Z_]+)_VERSION=([^[:space:]]+) ]]; then
            local var_prefix="${BASH_REMATCH[2]}"
            local ver="${BASH_REMATCH[3]}"
            packages+=("arg|${var_prefix}|$ver")
        fi
    done < "$DOCKERFILE"

    printf '%s\n' "${packages[@]}"
}

# Check for renovate datasource comments
get_datasource_for_package() {
    local pkg="$1"
    local datasource=""
    local dep_name=""

    # Look for renovate comment before the package
    local in_renovate_block=false
    while IFS= read -r line; do
        if [[ "$line" =~ ^#[[:space:]]*renovate:[[:space:]]*datasource=([^[:space:]]+)[[:space:]]+depName=([^[:space:]]+) ]]; then
            datasource="${BASH_REMATCH[1]}"
            dep_name="${BASH_REMATCH[2]}"
            in_renovate_block=true
        elif [ "$in_renovate_block" = true ]; then
            if [[ "$line" =~ $pkg ]]; then
                echo "$datasource|$dep_name"
                return
            elif [[ ! "$line" =~ \\ ]] && [[ ! "$line" =~ ^[[:space:]]*(RUN|ARG|ENV) ]] && [[ "$line" =~ ^[^#] ]]; then
                in_renovate_block=false
            fi
        fi
    done < "$DOCKERFILE"

    echo ""
}

# Main scanning logic
main() {
    echo -e "${CYAN}Scanning: $DOCKERFILE${NC}"
    echo "========================================"

    local updates_available=false
    local update_list=()

    # Extract all packages
    while IFS= read -r pkg_info; do
        [ -z "$pkg_info" ] && continue

        IFS='|' read -r type name version <<< "$pkg_info"

        if [ "$type" = "alpine" ]; then
            # Check for datasource
            local ds_info
            ds_info=$(get_datasource_for_package "$name")

            local latest=""
            if [ -n "$ds_info" ]; then
                IFS='|' read -r datasource dep_name <<< "$ds_info"
                if [ "$datasource" = "repology" ]; then
                    local repo="${dep_name%%/*}"
                    latest=$(query_repology_cached "$name" "$repo")
                fi
            else
                # Default to alpine_edge
                latest=$(query_repology_cached "$name" "alpine_edge")
            fi

            if [ -n "$latest" ] && [ "$latest" != "$version" ]; then
                echo -e "${YELLOW}UPDATE:${NC} $name: $version -> $latest"
                updates_available=true
                update_list+=("$type|$name|$version|$latest")
            else
                echo -e "${GREEN}OK:${NC} $name: $version"
            fi
        elif [ "$type" = "arg" ]; then
            # For ARG versions, check if there's a renovate comment
            local ds_info
            ds_info=$(get_datasource_for_package "VERSION=")

            if [ -n "$ds_info" ]; then
                IFS='|' read -r datasource dep_name <<< "$ds_info"
                if [ "$datasource" = "github-releases" ]; then
                    local latest
                    latest=$(curl -sf "https://api.github.com/repos/${dep_name}/releases/latest" 2>/dev/null | jq -r '.tag_name // empty')
                    if [ -n "$latest" ] && [ "$latest" != "$version" ]; then
                        echo -e "${YELLOW}UPDATE:${NC} ${name}_VERSION: $version -> $latest"
                        updates_available=true
                        update_list+=("$type|${name}_VERSION|$version|$latest")
                    else
                        echo -e "${GREEN}OK:${NC} ${name}_VERSION: $version"
                    fi
                fi
            else
                echo -e "${GREEN}OK:${NC} ${name}_VERSION: $version (no datasource)"
            fi
        fi
    done < <(extract_packages)

    echo "========================================"

    if [ "$updates_available" = true ]; then
        echo -e "${YELLOW}Updates available!${NC}"

        if [ "$DO_UPDATE" = "--update" ]; then
            echo "Applying updates..."
            for update in "${update_list[@]}"; do
                IFS='|' read -r type name old_ver new_ver <<< "$update"
                if [ "$type" = "alpine" ]; then
                    sed -i "s/${name}==${old_ver}/${name}==${new_ver}/g" "$DOCKERFILE"
                    sed -i "s/${name}=${old_ver}/${name}=${new_ver}/g" "$DOCKERFILE"
                    echo "  Updated $name: $old_ver -> $new_ver"
                elif [ "$type" = "arg" ]; then
                    sed -i "s/${name}=${old_ver}/${name}=${new_ver}/g" "$DOCKERFILE"
                    echo "  Updated $name: $old_ver -> $new_ver"
                fi
            done
            echo "Updates applied."
        fi
    else
        echo -e "${GREEN}All packages are up to date.${NC}"
    fi
}

main "$@"
