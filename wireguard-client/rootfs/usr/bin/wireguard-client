#!/usr/bin/with-contenv bashio
# ==============================================================================
# Hass.io Add-ons: WireGuard Client
# Configures WireGuard Client before running
# ==============================================================================
readonly conf=/ssl/wireguard-client/wg1.conf
readonly defconf=/defaults/wg1.conf

# Ensure configuration folder exists
if ! bashio::fs.directory_exists "$(dirname "${conf}")"; then
    mkdir -p "$(dirname "${conf}")" \
        || bashio::exit.nok "Failed to create WireGuard Client configuration directory"
    cp $defconf $conf
fi