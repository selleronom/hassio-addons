# Home Assistant Add-on: Cloudflared

## Configuration

### Option: `tunnel_token`

The tunnel token from your Cloudflare dashboard. This is the easiest way to configure cloudflared.

To get a tunnel token:
1. Go to https://dash.cloudflare.com
2. Navigate to Zero Trust > Access > Tunnels
3. Create a new tunnel or select an existing one
4. Copy the tunnel token

### Option: `tunnel_name`

The name of your tunnel if using credentials file instead of a token. Default: `homeassistant`

If not using a token, you'll need to place your tunnel credentials in `/data/tunnel-credentials.json`.

### Option: `metrics_port`

Port for the metrics endpoint. Default: `5053`

You can access metrics at `http://[HOST]:5053/metrics`

### Option: `log_level`

Logging verbosity level:
- `trace` - Most verbose
- `debug` - Debug information
- `info` - General information (default)
- `warn` - Warnings only
- `error` - Errors only
- `fatal` - Fatal errors only

### Option: `protocol`

Connection protocol to use:
- `auto` - Automatically select (default)
- `quic` - Use QUIC protocol
- `http2` - Use HTTP/2 protocol

### Option: `no_tls_verify`

Disable TLS verification. Default: `false`

**Warning**: Only enable this for testing purposes. Disabling TLS verification is insecure.

## Home Assistant Configuration

After setting up the tunnel, you need to configure Home Assistant to trust Cloudflare's proxy:

Add this to your `configuration.yaml`:

```yaml
http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 172.30.33.0/24
```

Then restart Home Assistant.

## Example Configuration

### Using Tunnel Token (Recommended)

```yaml
tunnel_token: "your-tunnel-token-here"
log_level: info
protocol: auto
metrics_port: 5053
```

### Using Named Tunnel

```yaml
tunnel_name: my-homeassistant-tunnel
log_level: info
protocol: quic
metrics_port: 5053
```

Note: You'll need to manually place credentials in `/data/tunnel-credentials.json`

## Support

For more information about Cloudflare Tunnels, visit:
- [Cloudflare Tunnel Documentation](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/)
- [GitHub Issue Tracker](https://github.com/selleronom/hassio-addons/issues)
