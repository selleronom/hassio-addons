# Home Assistant Add-on: Cloudflared

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

Cloudflare Tunnel client for secure remote access to Home Assistant without opening ports.

## About

Cloudflared creates a secure tunnel to Cloudflare's edge network, allowing you to access your Home Assistant instance remotely without opening ports on your router. This add-on uses the official Alpine Linux cloudflared package.

## Features

- Secure tunnel to Cloudflare's network
- No port forwarding required
- DDoS protection included
- Support for both tunnel tokens and named tunnels
- Configurable logging and protocol options
- Metrics endpoint for monitoring

## Installation

1. Add this repository to your Home Assistant instance
2. Install the "Cloudflared" add-on
3. Configure the add-on with your tunnel token or credentials
4. Start the add-on

## Support

For issues and feature requests, please use the [GitHub issue tracker](https://github.com/selleronom/hassio-addons/issues).

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
