#!/bin/bash

mkdir -p /share/snapfifo

CONFIG_PATH=/data/options.json

SHAIRPORT_NAME=$(jq --raw-output ".name" $CONFIG_PATH)

echo "Start Shairport-sync..."
/usr/bin/shairport-sync -a $SHAIRPORT_NAME
echo "Started"
