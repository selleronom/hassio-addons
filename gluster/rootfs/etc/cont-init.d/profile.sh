#!/usr/bin/with-contenv bashio
# ==============================================================================
# Setup persistent user settings
# ==============================================================================

# Persist shell history by redirecting .bash_history to /data
touch /data/.bash_history
chmod 600 /data/.bash_history
ln -s -f /data/.bash_history /root/.bash_history

# Sets up the users .ssh folder to be persistent
if ! bashio::fs.directory_exists /data/.ssh; then
    mkdir -p /data/.ssh \
        || bashio::exit.nok 'Failed to create a persistent .ssh folder'

    chmod 700 /data/.ssh \
        || bashio::exit.nok \
            'Failed setting permissions on persistent .ssh folder'
fi
ln -s /data/.ssh /root/.ssh