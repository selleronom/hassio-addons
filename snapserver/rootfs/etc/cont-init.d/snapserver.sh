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
username=$(bashio::config 'username')
password=$(bashio::config 'password')
volume=$(bashio::config 'volume')

if bashio::config.has_value 'username'; then
    {
        echo "stream = spotify:///librespot?name=Spotify&devicename=${name}&bitrate=${bitrate}&volume=${volume}&username=${username}&password=${password}"
    } >> /etc/snapserver.conf
else
    {
        echo "stream = spotify:///librespot?name=Spotify&devicename=${name}&bitrate=${bitrate}&volume=${volume}"
    } >> /etc/snapserver.conf
fi