#!/usr/bin/with-contenv bash
set -euo pipefail

OPTIONS_FILE=/data/options.json

if [[ ! -e "${OPTIONS_FILE}" ]]; then
	printf '{}' >"${OPTIONS_FILE}"
fi

read_option() {
	local query="$1"
	local fallback="$2"

	if [[ -r "${OPTIONS_FILE}" ]]; then
		jq -r "${query} // ${fallback}" "${OPTIONS_FILE}" 2>/dev/null || jq -nr "${fallback}"
	else
		jq -nr "${fallback}"
	fi
}

export TZ="$(read_option '.TZ' '"Etc/UTC"')"
export IMMICH_LOG_LEVEL="$(read_option '.IMMICH_LOG_LEVEL' '"log"')"
export IMMICH_MEDIA_LOCATION="$(read_option '.IMMICH_MEDIA_LOCATION' '"/media/immich"')"
export IMMICH_MACHINE_LEARNING_ENABLED="$(read_option '.IMMICH_MACHINE_LEARNING_ENABLED' 'false')"
export IMMICH_MACHINE_LEARNING_URL="$(read_option '.IMMICH_MACHINE_LEARNING_URL' '"http://immich-machine-learning:3003"')"
export IMMICH_PROCESS_INVALID_IMAGES="$(read_option '.IMMICH_PROCESS_INVALID_IMAGES' 'empty')"
export PUID="$(read_option '.PUID' '911')"
export PGID="$(read_option '.PGID' '911')"
export APPLY_PERMISSIONS="$(read_option '.APPLY_PERMISSIONS' 'false')"
export CLEAN_REDIS="$(read_option '.clean_redis' 'false')"

# Static local service wiring in the all-in-one container.
export DB_USERNAME="${POSTGRES_USER:-immich}"
export DB_PASSWORD="${POSTGRES_PASSWORD:-immich}"
export DB_DATABASE_NAME="${POSTGRES_DB:-immich}"
export DB_HOSTNAME="127.0.0.1"
export DB_PORT="5432"
export DB_URL="postgresql://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOSTNAME}:${DB_PORT}/${DB_DATABASE_NAME}"
export REDIS_HOSTNAME="127.0.0.1"
export REDIS_PORT="6379"
export REDIS_SOCKET="/var/run/redis/redis.sock"

if [[ -r "${OPTIONS_FILE}" ]]; then
	while IFS= read -r row; do
		key="$(jq -r '.key' <<<"${row}")"
		value="$(jq -r '.value' <<<"${row}")"
		if [[ -n "${key}" ]]; then
			export "${key}=${value}"
		fi
	done < <(jq -c '.env_vars // [] | .[]' "${OPTIONS_FILE}" 2>/dev/null)
fi
