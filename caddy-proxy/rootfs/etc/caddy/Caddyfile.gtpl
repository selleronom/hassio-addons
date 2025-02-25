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
}

https://{{ .options.domain }}:443 {
    tls /ssl/{{ .options.certfile }} /ssl/{{ .options.keyfile }}
    encode gzip
    reverse_proxy http://homeassistant.local.hass.io:{{ .variables.port }} {
        {{ if .options.trusted_proxies }}
        trusted_proxies {{ .options.trusted_proxies }}
        {{ end }}
    }
}