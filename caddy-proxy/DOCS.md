# Home Assistant Add-on: Caddy Home Assistant SSL proxy

## Installation

Follow these steps to get the add-on installed on your system:

1. Navigate in your Home Assistant frontend to **Settings** -> **Add-ons** -> **Add-on store**.
2. Find the "Caddy Home Assistant SSL proxy" add-on and click it.
3. Click on the "INSTALL" button.

## How to use

The Caddy Proxy add-on is commonly used in conjunction with the [Duck DNS](https://github.com/home-assistant/addons/tree/master/duckdns) add-on to set up secure remote access to your Home Assistant instance. The following instructions covers this scenario.

1. The certificate to your registered domain should already be created via [Duck DNS](https://github.com/home-assistant/addons/tree/master/duckdns) or another method. Make sure that the certificate files exist in the `/ssl` directory.
2. You must add the following section to your [Home Assistant configuration.yaml](https://www.home-assistant.io/docs/configuration/):

   ```yaml
   http:
     use_x_forwarded_for: true
     trusted_proxies:
       - 172.30.33.0/24
   ```
3. In the Caddy addon configuration, change the `domain` option to the domain name you registered (from DuckDNS or any other domain you control).
4. Leave all other options as-is.
5. Save configuration.
6. Start the add-on.
7. Have some patience and wait a couple of minutes.
8. Check the add-on log output to see the result.

## Configuration

Add-on configuration:

```yaml
domain: home.example.com
certfile: public.crt
keyfile: private.key
trusted_proxies: 192.168.1.1/32
```

### Option: `domain` (required)

The server's fully qualified domain name to use for the proxy.

### Option: `certfile` (required)

The certificate file to use in the `/ssl` directory. Keep filename as-is if you used default settings to create the certificate with the [Duck DNS](https://github.com/home-assistant/addons/tree/master/duckdns) add-on.

### Option: `keyfile` (required)

Private key file to use in the `/ssl` directory.

### Option: `trusted_proxies` (optional)

Defines a list of trusted proxies. This is useful if you're running your Home Assistant instance behind another proxy.

## Support

Got questions?

You have several options to get them answered:

- The [Home Assistant Discord Chat Server][discord].
- The Home Assistant [Community Forum][forum].
- Join the [Reddit subreddit][reddit] in [/r/homeassistant][reddit]

In case you've found a bug, please [open an issue on our GitHub][issue].

[discord]: https://discord.gg/c5DvZ4e
[forum]: https://community.home-assistant.io
[issue]: https://github.com/home-assistant/addons/issues
[reddit]: https://reddit.com/r/homeassistant
[repository]: https://github.com/hassio-addons/repository
