#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Bitwarden
# ==============================================================================
declare host

host=$(bashio::services "mysql" "host")

exec /bin/mount -t glusterfs "${host}":/gv0 /data
