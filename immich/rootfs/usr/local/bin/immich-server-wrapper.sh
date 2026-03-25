#!/usr/bin/with-contenv bash
set -euo pipefail

export NODE_ENV=production
export IMMICH_ENV=production
export IMMICH_PORT="${SERVER_PORT:-2283}"
export IMMICH_HOST=0.0.0.0
export HOME="/data"
export NODE_OPTIONS="--dns-result-order=ipv4first"

if [[ -x /usr/src/app/server/bin/start.sh ]]; then
	exec /bin/bash -c 'cd /usr/src/app/server/bin && exec ./start.sh'
fi

if [[ -x /usr/local/bin/start.sh ]]; then
	exec /bin/bash -c 'cd /usr/src/app && exec /usr/local/bin/start.sh'
fi

if [[ -x /usr/src/app/server/bin/immich ]]; then
	exec /usr/src/app/server/bin/immich
fi

echo "Unable to locate Immich server startup command" >&2
exit 1
