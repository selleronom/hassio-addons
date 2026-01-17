#!/usr/bin/env bash
set -e

# Script to update addon version based on Dockerfile changes
# Usage: ./scripts/update-addon-version.sh [base_ref]

BASE_REF="${1:-HEAD~1}"
DRY_RUN="${DRY_RUN:-false}"

echo "========================================="
echo "🔍 Add-on Version Updater"
echo "========================================="

# Detect changed Dockerfile
echo "Detecting changed Dockerfile..."
if [[ "$BASE_REF" == "origin/"* ]]; then
    # PR mode - compare against base branch
    git fetch origin "${BASE_REF#origin/}" 2>/dev/null || true
    changed_file=$(git diff --name-only "$BASE_REF"...HEAD | grep 'Dockerfile' | head -n1)
else
    # Local mode - compare against commit
    changed_file=$(git diff --name-only "$BASE_REF" | grep 'Dockerfile' | head -n1)
fi

if [ -z "$changed_file" ]; then
    echo "❌ No Dockerfile changes detected"
    exit 0
fi

addon_dir=$(dirname "$changed_file")
echo "✅ Detected addon: $addon_dir"

# Check for config file
dockerfile="${addon_dir}/Dockerfile"
config_file="${addon_dir}/config.yaml"

if [ ! -f "$config_file" ]; then
    echo "⚠️  Config file not found: $config_file"
    exit 0
fi

# Get current config version
current_config=$(yq eval '.version' "$config_file")
echo "📌 Current config version: $current_config"

# Extract main package version from Dockerfile
echo "🔎 Extracting main package version from Dockerfile..."
main_pkg_version=$(awk '/# *main_package/{getline; print; exit}' "$dockerfile" | \
    sed 's/^[[:space:]]*//; s/[[:space:]]*$//' | \
    grep -oE '[^=[:space:]]+=[^ \\]+' | \
    head -n1 | \
    sed 's/.*=//')

if [ -z "$main_pkg_version" ]; then
    echo "❌ ERROR: Could not detect main package version (expected '# main_package' marker)"
    exit 1
fi

echo "📦 Found main package version: $main_pkg_version"

# Parse current config version to extract base and suffix
# Format expected: "version" or "version-suffix" where suffix is our build number
# We need to distinguish between Alpine's -rX and our -suffix
if [[ "$current_config" =~ ^(.+-r[0-9]+)-([0-9]+)$ ]]; then
    # Has our build suffix: e.g., "2.10.2-r2-5"
    current_base="${BASH_REMATCH[1]}"
    current_suffix="${BASH_REMATCH[2]}"
else
    # No build suffix yet: e.g., "2.10.2-r2"
    current_base="$current_config"
    current_suffix="0"
fi

echo "🔧 Parsed config - base: $current_base, suffix: $current_suffix"

# Compare main package version to determine new version
if [ "$current_base" = "$main_pkg_version" ]; then
    # Same package version, increment suffix
    new_version="${main_pkg_version}-$((current_suffix + 1))"
    echo "➕ Main package unchanged, incrementing build suffix"
else
    # New package version, reset to -1
    new_version="${main_pkg_version}-1"
    echo "🆕 Main package changed from $current_base to $main_pkg_version, resetting suffix"
fi

echo ""
echo "========================================="
echo "📝 Version Update Summary"
echo "========================================="
echo "Addon:       $addon_dir"
echo "Old version: $current_config"
echo "New version: $new_version"
echo "========================================="

# Update config.yaml
if [ "$DRY_RUN" = "true" ]; then
    echo "🔍 DRY RUN MODE - No changes made"
else
    yq eval -i ".version = \"${new_version}\"" "$config_file"
    echo "✅ Updated $config_file"
fi

# Output for GitHub Actions (if running in CI)
if [ -n "$GITHUB_OUTPUT" ]; then
    {
        echo "updated=true"
        echo "old_version=${current_config}"
        echo "new_version=${new_version}"
        echo "addon_dir=${addon_dir}"
    } >> "$GITHUB_OUTPUT"
fi

# Also output as regular variables for local use
echo ""
echo "Export variables:"
echo "export ADDON_DIR='$addon_dir'"
echo "export OLD_VERSION='$current_config'"
echo "export NEW_VERSION='$new_version'"
