{{/*
    Options saved in the addon UI are available in .options
    Some variables are available in .variables, these are added in nginx/run
*/}}

{
	log {
		output stdout
		format console
		level info
	}
	auto_https off
}

https://{{ .options.domain }}:443 {
    tls /ssl/{{ .options.certfile }} /ssl/{{ .options.keyfile }}

    header Cache-Control "no-cache, no-store, must-revalidate"

    reverse_proxy http://homeassistant.local.hass.io:{{ .variables.port }} {
        header_up Host {host}
        header_up X-Real-IP {remote_host}
        header_up X-Forwarded-Proto {scheme}
        {{ if .options.trusted_proxies }}
        trusted_proxies {{ .options.trusted_proxies }}
        {{ end }}
    }
}
