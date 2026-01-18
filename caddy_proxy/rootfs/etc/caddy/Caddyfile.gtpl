{{/* Options saved in the addon UI are available in .options */}}

{
	storage file_system /data
	auto_https disable_redirects
	log {
		output stdout
		format console
		level {{ .options.log_level }}
	}
	acme_dns cloudflare {{ .options.cloudflare_api_token }}
}

*.{{ .options.domain }}, {{ .options.domain }} {
	tls {
		dns cloudflare {{ .options.cloudflare_api_token }}
	}

	{{ range .options.proxies }}
	{{ if .subdomain }}
	@{{ .subdomain }} host {{ .subdomain }}.{{ $.options.domain }}
	handle @{{ .subdomain }} {
		reverse_proxy {{ .target_protocol }}://{{ .target_host }}:{{ .target_port }} {
			{{ if $.options.trusted_proxies }}
			trusted_proxies {{ $.options.trusted_proxies }}
			{{ end }}
			{{ if and (eq .target_protocol "https") .insecure }}
			transport http {
				tls_insecure_skip_verify
			}
			{{ end }}
		}
	}
	{{ else }}
	@root host {{ $.options.domain }}
	handle @root {
		reverse_proxy {{ .target_protocol }}://{{ .target_host }}:{{ .target_port }} {
			{{ if $.options.trusted_proxies }}
			trusted_proxies {{ $.options.trusted_proxies }}
			{{ end }}
			{{ if and (eq .target_protocol "https") .insecure }}
			transport http {
				tls_insecure_skip_verify
			}
			{{ end }}
		}
	}
	{{ end }}
	{{ end }}

	handle {
		respond "Not found" 404
	}
}
