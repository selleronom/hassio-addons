#!/bin/bash

echo "Start Avahi-daemon..."
/usr/sbin/avahi-daemon -D
echo "Started"

CONFIG_PATH=/data/options.json

SNAPSERVER_OPTS=$(jq --raw-output ".snapserveropts" $CONFIG_PATH)

mkdir -p /share/snapfifo
mkdir -p /var/lib/snapserver/
printf '{\n\t"ConfigVersion": 2,\n\t"Groups": []\n}' > /var/lib/snapserver/server.json

echo "Start Snapserver..."
/usr/bin/snapserver ${SNAPSERVER_OPTS}
echo "Started"
