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

# Core
export NEXTAUTH_SECRET="$(read_option '.NEXTAUTH_SECRET' '""')"
export MEILI_MASTER_KEY="$(read_option '.MEILI_MASTER_KEY' '""')"

nextauth_url="$(read_option '.NEXTAUTH_URL' '""')"
if [[ -n "${nextauth_url}" ]]; then
	export NEXTAUTH_URL="${nextauth_url}"
else
	export NEXTAUTH_URL="http://localhost:3000"
fi

# General
export TZ="$(read_option '.TZ' '"Etc/UTC"')"
export LOG_LEVEL="$(read_option '.LOG_LEVEL' '"debug"')"
export DISABLE_SIGNUPS="$(read_option '.DISABLE_SIGNUPS' '"false"')"
export DB_WAL_MODE="$(read_option '.DB_WAL_MODE' '"true"')"
export MAX_ASSET_SIZE_MB="$(read_option '.MAX_ASSET_SIZE_MB' '50')"

# AI / Inference
openai_key="$(read_option '.OPENAI_API_KEY' '""')"
[[ -n "${openai_key}" ]] && export OPENAI_API_KEY="${openai_key}"

openai_base="$(read_option '.OPENAI_BASE_URL' '""')"
[[ -n "${openai_base}" ]] && export OPENAI_BASE_URL="${openai_base}"

ollama_base="$(read_option '.OLLAMA_BASE_URL' '""')"
[[ -n "${ollama_base}" ]] && export OLLAMA_BASE_URL="${ollama_base}"

export INFERENCE_TEXT_MODEL="$(read_option '.INFERENCE_TEXT_MODEL' '"gpt-4.1-mini"')"
export INFERENCE_IMAGE_MODEL="$(read_option '.INFERENCE_IMAGE_MODEL' '"gpt-4o-mini"')"
export INFERENCE_LANG="$(read_option '.INFERENCE_LANG' '"english"')"

# Crawler
export CRAWLER_VIDEO_DOWNLOAD="$(read_option '.CRAWLER_VIDEO_DOWNLOAD' '"false"')"
export OCR_LANGS="$(read_option '.OCR_LANGS' '"eng"')"

# Monitoring
prometheus_token="$(read_option '.PROMETHEUS_AUTH_TOKEN' '""')"
[[ -n "${prometheus_token}" ]] && export PROMETHEUS_AUTH_TOKEN="${prometheus_token}"

# Fixed internal service wiring
export DATA_DIR="/data"
export PORT="3000"
export MEILI_ADDR="http://127.0.0.1:7700"
export MEILI_NO_ANALYTICS="true"
export BROWSER_WEB_URL="http://127.0.0.1:9222"
export NEXTAUTH_URL_INTERNAL="http://localhost:3000"

# Memory-tuned defaults for constrained environments
export CRAWLER_NUM_WORKERS="${CRAWLER_NUM_WORKERS:-1}"
export INFERENCE_NUM_WORKERS="${INFERENCE_NUM_WORKERS:-1}"
export SEARCH_NUM_WORKERS="${SEARCH_NUM_WORKERS:-1}"
export CRAWLER_PARSER_MEM_LIMIT_MB="${CRAWLER_PARSER_MEM_LIMIT_MB:-256}"

# Process custom env_vars from options (catch-all for any Karakeep env var)
if [[ -r "${OPTIONS_FILE}" ]]; then
	while IFS= read -r row; do
		key="$(jq -r '.key' <<<"${row}")"
		value="$(jq -r '.value' <<<"${row}")"
		if [[ -n "${key}" ]]; then
			export "${key}=${value}"
		fi
	done < <(jq -c '.env_vars // [] | .[]' "${OPTIONS_FILE}" 2>/dev/null)
fi
