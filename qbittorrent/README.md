# Home Assistant Add-on: qBittorrent

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg

qBittorrent is a free and reliable P2P BitTorrent client built with Alpine Linux and the latest qbittorrent-nox package.

## About

qBittorrent is a cross-platform BitTorrent client that aims to provide an open-source alternative to µTorrent. This add-on packages qBittorrent in a lightweight Alpine Linux container with proper s6-overlay v3 supervision.

## Features

- 🚀 Built on Alpine Linux for minimal footprint
- 🔧 Highly configurable through the add-on options
- 📁 Automatic directory creation for downloads
- 🔒 Optional SSL/TLS support
- ⏰ Built-in scheduler for alternative rate limits
- 🎯 Proper s6-overlay v3 supervision
- 🌐 Web UI accessible from Home Assistant

## Installation

1. Add this repository to your Home Assistant instance:

   [![Add Repository](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/Selleronom/hassio-addons)

2. Find the "qBittorrent" add-on and click it
3. Click "INSTALL"
4. Configure the add-on options (see below)
5. Click "START"

## Configuration

**Note**: _Remember to restart the add-on when the configuration is changed._

Example add-on configuration:

```yaml
webui_port: 8080
bt_port: 6881
save_path: /share/qbittorrent/downloads
temp_path: /share/qbittorrent/temp
max_connec: 500
max_connec_per_torrent: 100
max_uploads: 15
max_uploads_per_torrent: 4
limit_utp_rate: true
limit_tcp_overhead: false
alt_dl_limit: 10240
alt_up_limit: 10240
scheduler_enabled: false
ssl_enabled: false
```

### Option: `webui_port`

The port for the qBittorrent Web UI (default: 8080).

### Option: `bt_port`

The port for BitTorrent connections (default: 6881).

### Option: `save_path`

The path where completed downloads will be saved.

### Option: `temp_path`

The path for incomplete downloads.

### Option: `max_connec`

Maximum number of connections (default: 500).

### Option: `max_connec_per_torrent`

Maximum number of connections per torrent (default: 100).

### Option: `max_uploads`

Maximum number of upload slots (default: 15).

### Option: `max_uploads_per_torrent`

Maximum number of upload slots per torrent (default: 4).

### Option: `alt_dl_limit`

Alternative download rate limit in KiB/s (default: 10240 = 10 MB/s).

### Option: `alt_up_limit`

Alternative upload rate limit in KiB/s (default: 10240 = 10 MB/s).

### Option: `scheduler_enabled`

Enable the bandwidth scheduler (default: false).

### Option: `ssl_enabled`

Enable SSL/TLS for the Web UI (default: false).

## Usage

1. Access the Web UI at `http://homeassistant.local:8080` (or your configured port)
2. Default login credentials:
   - Username: `admin`
   - Password: `adminadmin`
3. **Important**: Change the default password immediately after first login!

## Support

Got questions?

Open an issue on GitHub:

[https://github.com/Selleronom/hassio-addons/issues](https://github.com/Selleronom/hassio-addons/issues)

## Authors & Contributors

This add-on is maintained by [Erik Montnemery](https://github.com/Selleronom).

## License

MIT License

Copyright (c) 2025 Erik Montnemery
