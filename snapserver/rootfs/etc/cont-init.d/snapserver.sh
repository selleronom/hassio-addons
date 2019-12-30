#!/usr/bin/with-contenv bashio
# ==============================================================================
# Sets up the configuration file for snapserver
# ==============================================================================
declare name
declare bitrate

if ! bashio::config.has_value 'name'; then
    bashio::log.fatal
    bashio::log.fatal "Add-on configuration is incomplete!"
    bashio::log.fatal
    bashio::log.fatal "The Snapcast server needs to be identifiable with a name"
    bashio::log.fatal "and it seems you haven't configured one."
    bashio::log.fatal
    bashio::log.fatal "Please set the 'name' add-on option."
    bashio::log.fatal
    bashio::exit.nok
fi
if ! bashio::config.has_value 'bitrate'; then
    bashio::log.fatal
    bashio::log.fatal "Add-on configuration is incomplete!"
    bashio::log.fatal
    bashio::log.fatal "The Snapcast server needs a bitrate"
    bashio::log.fatal "and it seems you haven't configured one."
    bashio::log.fatal
    bashio::log.fatal "Please set the 'bitrate' add-on option."
    bashio::log.fatal
    bashio::exit.nok
fi

name=$(bashio::config 'name')
bitrate=$(bashio::config 'bitrate')

{
    echo "stream = spotify:///librespot?name=Spotify&devicename=${name}&bitrate=${bitrate}"
} >> /etc/snapserver.conf
