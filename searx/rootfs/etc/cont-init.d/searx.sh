#!/usr/bin/with-contenv bashio
# ==============================================================================
# Sets up the configuration file for searx
# ==============================================================================
config=/etc/searx/settings.yml

sed -i 's/instance_name : "searx"/instance_name : '"$(bashio::config 'instance_name')"'/g' "${config}"
sed -i 's/autocomplete : ""/autocomplete : '"$(bashio::config 'autocomplete')"'/g' "${config}"
sed -i 's/secret_key : "ultrasecretkey"/secret_key : '"$(bashio::config 'secret_key')"'/g' "${config}"
sed -i 's~base_url : False~base_url : '"$(bashio::config 'base_url')"'~g' "${config}"
sed -i 's/http_protocol_version : "1.0"/http_protocol_version : '"$(bashio::config 'http_protocol_version')"'/g' "${config}"
sed -i 's/image_proxy : "False"/image_proxy : '"$(bashio::config 'image_proxy')"'/g' "${config}"

if bashio::var.true $(bashio::config 'enable_all_engines'); then
    sed -i '/disabled : True/d' "${config}"
fi
