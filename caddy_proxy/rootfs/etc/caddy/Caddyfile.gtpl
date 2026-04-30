{{/* Options saved in the addon UI are available in .options */}}

{
	storage file_system /data
	auto_https disable_redirects
	log {
		output stdout
		format console
		level {{ .options.log_level }}
	}
	{{ if .options.trusted_proxies }}
	servers {
		trusted_proxies static {{ .options.trusted_proxies }}
	}
	{{ end }}
}

*.{{ .options.domain }}, {{ .options.domain }} {
	tls {
		dns cloudflare {{ .options.cloudflare_api_token }}
		resolvers 1.1.1.1
	}

	{{ range .options.proxies }}
	{{ if .subdomain }}
	@{{ .subdomain }} host {{ .subdomain }}.{{ $.options.domain }}
	handle @{{ .subdomain }} {
        {{ if .webhook_uri }}
        forward_auth {{ .webhook_uri }}
        {{ end }}
        reverse_proxy {{ .target_protocol }}://{{ .target_host }}:{{ .target_port }} {
            flush_interval -1
            {{ if eq .target_protocol "https" }}
            header_up Host {host}
            {{ end }}
            {{ if and (eq .target_protocol "https") .insecure }}
            transport http {
                tls_insecure_skip_verify
            }
            {{ end }}
            {{ if .webhook_uri }}
            lb_try_duration {{ if .webhook_ready_timeout }}{{ .webhook_ready_timeout }}{{ else }}120s{{ end }}
            lb_try_interval 5s
            health_uri {{ if .webhook_health_uri }}{{ .webhook_health_uri }}{{ else }}/health{{ end }}
            health_interval 10s
            {{ end }}
        }
    }
	{{ end }}
	{{ end }}

	handle {
		respond "Not found" 404
	}
}
