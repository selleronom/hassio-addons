#!/usr/bin/env bash
set -e

BASE_REF="${1:-HEAD~1}"

echo "Detecting changed Dockerfiles..."
if [[ "$BASE_REF" == "origin/"* ]]; then
	git fetch origin "${BASE_REF#origin/}" 2>/dev/null || true
	changed_files=$(git diff --name-only "$BASE_REF"...HEAD | grep 'Dockerfile' || true)
else
	changed_files=$(git diff --name-only "$BASE_REF" | grep 'Dockerfile' || true)
fi

if [ -z "$changed_files" ]; then
	echo "No Dockerfile changes detected"
	exit 0
fi

updated_addons=()

while IFS= read -r changed_file; do
	[ -z "$changed_file" ] && continue

	addon_dir=$(dirname "$changed_file")
	config_file="${addon_dir}/config.yaml"

	if [ ! -f "$config_file" ]; then
		echo "No config.yaml in $addon_dir, skipping"
		continue
	fi

	echo "Processing: $addon_dir"

	# Try renovate-annotated Alpine package (line after # renovate: datasource=repology)
	version=$(awk '/# renovate: datasource=repology/{getline; match($0, /[a-z][a-z0-9_-]+=([0-9][^ \\]*)/, arr); if (arr[1]) print arr[1]}' "$changed_file" | head -1)

	# Fall back to first ARG *_VERSION= (immich/github-release style), strip leading v
	if [ -z "$version" ]; then
		version=$(grep -m1 'ARG [A-Z_]*VERSION=' "$changed_file" | sed 's/.*VERSION=v\?//' | tr -d '"' || true)
	fi

	if [ -z "$version" ]; then
		echo "Could not detect version in $changed_file, skipping"
		continue
	fi

	echo "Detected version: $version"

	current=$(grep '^version:' "$config_file" | sed 's/version:[[:space:]]*//' | tr -d '"')

	if [[ "$current" =~ ^(.*)-([0-9]+)$ ]]; then
		current_base="${BASH_REMATCH[1]}"
		current_suffix="${BASH_REMATCH[2]}"
	else
		current_base="$current"
		current_suffix="0"
	fi

	if [ "$current_base" = "$version" ]; then
		new_version="${version}-$((current_suffix + 1))"
	else
		new_version="${version}-1"
	fi

	echo "Version: $current → $new_version"
	sed -i "s/^version:.*/version: \"${new_version}\"/" "$config_file"
	updated_addons+=("$addon_dir")

done <<<"$changed_files"

if [ ${#updated_addons[@]} -eq 0 ]; then
	echo "No addons updated"
	exit 0
fi

if [ -n "$GITHUB_OUTPUT" ]; then
	echo "updated=true" >>"$GITHUB_OUTPUT"
	echo "addon_count=${#updated_addons[@]}" >>"$GITHUB_OUTPUT"
fi
