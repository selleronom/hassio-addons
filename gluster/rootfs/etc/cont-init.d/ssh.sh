#!/usr/bin/with-contenv bashio
# ==============================================================================
# SSH setup & user
# ==============================================================================

mkdir -p /var/run/sshd

if bashio::config.has_value 'authorized_keys'; then
    bashio::log.info "Setup authorized_keys"

    mkdir -p /data/.ssh
    chmod 700 /data/.ssh
    rm -f /data/.ssh/authorized_keys
    while read -r line; do
        echo "$line" >> /data/.ssh/authorized_keys
    done <<< "$(bashio::config 'authorized_keys')"

    chmod 600 /data/.ssh/authorized_keys
    sed -i s/#PasswordAuthentication.*/PasswordAuthentication\ no/ /etc/ssh/sshd_config

elif bashio::var.has_value "$(bashio::addon.port 2121)"; then
    bashio::exit.nok "You need to setup a login!"
fi
