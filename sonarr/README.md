# Home Assistant Add-on: Sonarr

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

Smart PVR for newsgroup and bittorrent users to automatically download TV shows.

## About

Sonarr is a PVR (Personal Video Recorder) for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new episodes of your favorite shows and will grab, sort, and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.

This add-on uses the official Alpine Linux sonarr package from the edge/testing repository.

## Features

- Automatic TV show downloading
- Support for major download clients (SABnzbd, NZBGet, qBittorrent, Transmission, etc.)
- Calendar view of upcoming episodes
- Automatic quality upgrades
- Custom formats and profiles
- Series and episode monitoring
- Manual search and download
- Beautiful web interface

## Installation

1. Add this repository to your Home Assistant instance
2. Install the "Sonarr" add-on
3. Start the add-on
4. Access the web interface at port 8989

## Support

For issues and feature requests, please use the [GitHub issue tracker](https://github.com/selleronom/hassio-addons/issues).

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
