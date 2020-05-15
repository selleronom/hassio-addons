#!/usr/bin/with-contenv bashio
# ==============================================================================
# Sets up the configuration file for murmur
# ==============================================================================

MUMBLE_SERVERPASSWORD=$(bashio::config 'serverpassword')
MUMBLE_BANDWIDTH=$(bashio::config 'bandwidth')
MUMBLE_REGISTERNAME=$(bashio::config 'registerName')
MUMBLE_CERTFILE=$(bashio::config 'certfile')
MUMBLE_KEYFILE=$(bashio::config 'keyfile')
MUMBLE_WELCOMETEXT=$(bashio::config 'welcometext')

#!/usr/bin/env sh
set -e

CONFIGFILE="/etc/murmur/murmur.ini"

setVal() {
    if [ -n "${1}" ] && [ -n "${2}" ]; then
        echo "update setting: ${1} with: ${2}"
        sed -i -E 's;#?('"${1}"'=).*;\1'"${2}"';' "${CONFIGFILE}"
    fi
}

setVal serverpassword "${MUMBLE_SERVERPASSWORD}"
setVal bandwidth "${MUMBLE_BANDWIDTH}"
setVal registerName "${MUMBLE_REGISTERNAME}"
setVal sslCert "${MUMBLE_CERTFILE}"
setVal sslKey "${MUMBLE_KEYFILE}"
setVal welcometext "${MUMBLE_WELCOMETEXT}"
