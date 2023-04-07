#!/usr/bin/with-contenv bashio
# ==============================================================================
# UNBOUND config
# ==============================================================================

CONFIG="/etc/unbound/unbound.conf"
bashio::log.info "Configuring unbound..."
cp /usr/share/tempio/unbound.config /etc/unbound/unbound.conf
