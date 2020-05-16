#!/usr/bin/with-contenv bashio
# ==============================================================================
# Sets up the configuration file for librespot
# ==============================================================================

# Create snapfifo dir
bashio::log.info 'Create snapfifo dir...'

mkdir -p /share/snapfifo

# Create librespot fifo
bashio::log.info 'Create fifo file...'

mkfifo /share/snapfifo/librespot
