# selleronom Home Assistant app repository

Personal Home Assistant apps repository.

Apps documentation: <https://developers.home-assistant.io/docs/apps>

[![Open your Home Assistant instance and show the app store with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_store.svg)](https://my.home-assistant.io/redirect/supervisor_store/?repository_url=https%3A%2F%2Fgithub.com%2Fselleronom%2Fhassio-addons)

## Apps

This repository contains the following apps

### [Caddy Proxy](./caddy_proxy)

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

_A reverse proxy using Caddy with Cloudflare DNS support._

### [Garage S3](./garage)

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

_Lightweight S3-compatible storage server._

### [Gitea](./gitea)

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

_Self-hosted Git service._

### [Immich](./immich)

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

_High performance self-hosted photo and video management solution._

### [iSponsorBlockTV](./isponsorblocktv)

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

_Skip sponsor segments in YouTube videos on YouTube TV devices._

### [Jellyfin](./jellyfin)

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

_Jellyfin media server._

### [qBittorrent](./qbittorrent)

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

_A free and reliable P2P BitTorrent client._

### [Restic Backup](./restic_backup)

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

_Scheduled restic backup of media, share and HA backups._

### [Syncthing](./syncthing)

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

_Continuous file synchronization program._

<!--

Notes for local development:
- While developing, comment out the 'image' key from the app's 'config.yaml' to make the supervisor build the app locally.
  - Remember to put this back when pushing up your changes.
- When you merge to the 'main' branch a new build will be triggered.
  - Make sure you adjust the 'version' key in the app's 'config.yaml' when you do that.
  - The first time this runs you might need to adjust the image configuration on GitHub Container Registry to make it public.
  - You may also need to adjust the GitHub Actions configuration (Settings > Actions > General > Workflow > Read & Write).

-->

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
