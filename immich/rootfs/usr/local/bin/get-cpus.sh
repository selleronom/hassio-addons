#!/bin/bash
set -euo pipefail

if command -v nproc >/dev/null 2>&1; then
	nproc
	exit 0
fi

getconf _NPROCESSORS_ONLN
