#!/bin/bash

CONFIG_PATH=/data/options.json

LIBRESPOT_OPTS=$(jq --raw-output ".librespotopts" $CONFIG_PATH)

mkdir -p /share/snapfifo
mkfifo /share/snapfifo/librespot

echo "Start Librespot..."
librespot ${LIBRESPOT_OPTS}
