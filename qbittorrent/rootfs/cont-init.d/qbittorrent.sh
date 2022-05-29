#!/usr/bin/with-contenv bashio
# ==============================================================================
# Hass.io Add-ons: qBittorrent
# Configures qBittorrent before running
# ==============================================================================
readonly conf=/config/qBittorrent/config/qBittorrent.conf
readonly defconf=/defaults/qBittorrent.conf

# Ensure configuration folder exists
if ! bashio::fs.directory_exists "$(dirname "${conf}")"; then
    mkdir -p "$(dirname "${conf}")" \
        || bashio::exit.nok "Failed to create qBittorrent configuration directory"
    cp $defconf $conf
fi