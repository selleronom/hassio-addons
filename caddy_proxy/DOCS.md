# Caddy Proxy Manager

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

| Option                 | Required | Description                                               |
| ---------------------- | -------- | --------------------------------------------------------- |
| `domain`               | Yes      | Domain for wildcard certificate (`*.domain` and `domain`) |
| `cloudflare_api_token` | Yes      | Cloudflare API token with DNS edit permissions            |
| `trusted_proxies`      | No       | CIDR notation for trusted proxies                         |
| `proxies`              | Yes      | Array of reverse proxy targets                            |

### Proxy entry

| Option            | Description                                |
| ----------------- | ------------------------------------------ |
| `subdomain`       | Subdomain to match (empty for root domain) |
| `target_host`     | Backend host                               |
| `target_port`     | Backend port                               |
| `target_protocol` | `http` or `https`                          |
| `insecure`        | Skip TLS verification for HTTPS backends   |
| `webhook`         | Optional wake-on-request hook (see below)  |

### Webhook (optional)

Fires a request to a webhook on every incoming request before proxying, then waits for the backend to come up. Useful for waking a sleeping host via a Home Assistant webhook automation that triggers Wake-on-LAN.

| Option          | Required | Description                                               |
| --------------- | -------- | --------------------------------------------------------- |
| `host`          | Yes      | Webhook host (e.g. `homeassistant.local`)                 |
| `path`          | Yes      | Webhook path (e.g. `/api/webhook/<id>`)                   |
| `port`          | No       | Webhook port (defaults to 80)                             |
| `health_uri`    | No       | Path on backend to poll while waiting (default `/health`) |
| `ready_timeout` | No       | How long to wait for backend (default `120s`)             |

Note: the webhook returns a 2xx for the proxied request to proceed; non-2xx responses are sent back to the client.

Example:

```yaml
proxies:
  - subdomain: inference
    target_host: edesktop.home.arpa
    target_port: 8080
    target_protocol: http
    insecure: false
    webhook:
      host: homeassistant.local
      port: 8123
      path: /api/webhook/-_fqIY48GNwAcMVuK22_jcWan
      health_uri: /health
      ready_timeout: 120s
```
