#!/usr/bin/with-contenv bashio
# ==============================================================================
# Sets up the configuration file for librespot
# ==============================================================================

# Create snapfifo dir
bashio::log.info 'Create snapfifo dir and fifo file...'

mkdir -p /share/snapfifo
mkfifo /share/snapfifo/librespot
