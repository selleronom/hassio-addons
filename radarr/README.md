# Home Assistant Add-on: Radarr

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

Movie collection manager for Usenet and BitTorrent users to automatically download movies.

## About

Radarr is a movie collection manager for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new movies and will interface with clients and indexers to grab, sort, and rename them. It can also be configured to automatically upgrade the quality of existing files in the library when a better quality format becomes available.

This add-on uses the official Alpine Linux radarr package from the edge/testing repository.

## Features

- Automatic movie downloading
- Support for major download clients (SABnzbd, NZBGet, qBittorrent, Transmission, etc.)
- Calendar view of upcoming releases
- Automatic quality upgrades
- Custom formats and profiles
- Movie monitoring and discovery
- Manual search and download
- Beautiful web interface
- Integration with popular media servers (Plex, Jellyfin, Emby, Kodi)

## Installation

1. Add this repository to your Home Assistant instance
2. Install the "Radarr" add-on
3. Start the add-on
4. Access the web interface at port 7878

## Support

For issues and feature requests, please use the [GitHub issue tracker](https://github.com/selleronom/hassio-addons/issues).

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
