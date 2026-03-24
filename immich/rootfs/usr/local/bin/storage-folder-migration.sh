#!/usr/bin/with-contenv bash
set -euo pipefail

source_dir="${1:-}"
target_dir="${2:-}"

if [[ -z "${source_dir}" || -z "${target_dir}" || "${source_dir}" == "${target_dir}" ]]; then
	exit 0
fi

if [[ ! -d "${source_dir}" ]]; then
	exit 0
fi

source_real="$(realpath -m "${source_dir}")"
target_real="$(realpath -m "${target_dir}")"

if [[ "${source_real}" == "${target_real}" ]]; then
	exit 0
fi

# Prevent recursive move attempts like /media -> /media/new.
if [[ "${target_real}" == "${source_real}"/* ]]; then
	echo "Refusing migration from ${source_real} to nested target ${target_real}" >&2
	exit 1
fi

mkdir -p "${target_dir}"
rsync -a --remove-source-files "${source_real}/" "${target_real}/"
find "${source_dir}" -type d -empty -delete || true
