# Caddy Proxy

## Setup

1. Create a Cloudflare API token with "Zone:DNS:Edit" permissions
2. Add to Home Assistant `configuration.yaml`:
   ```yaml
   http:
     use_x_forwarded_for: true
     trusted_proxies:
       - 172.30.33.0/24
   ```
3. Configure the add-on and start

## Configuration

```yaml
domain: example.com
cloudflare_api_token: "your-token"
trusted_proxies: null
proxies:
  - subdomain: ""
    target_host: homeassistant.local.hass.io
    target_port: 8123
    target_protocol: http
    insecure: false
  - subdomain: "jellyfin"
    target_host: 192.168.1.100
    target_port: 8096
    target_protocol: http
    insecure: false
```

## Options

| Option | Required | Description |
|--------|----------|-------------|
| `domain` | Yes | Domain for wildcard certificate (`*.domain` and `domain`) |
| `cloudflare_api_token` | Yes | Cloudflare API token with DNS edit permissions |
| `trusted_proxies` | No | CIDR notation for trusted proxies |
| `proxies` | Yes | Array of reverse proxy targets |

### Proxy entry

| Option | Description |
|--------|-------------|
| `subdomain` | Subdomain to match (empty for root domain) |
| `target_host` | Backend host |
| `target_port` | Backend port |
| `target_protocol` | `http` or `https` |
| `insecure` | Skip TLS verification for HTTPS backends |
