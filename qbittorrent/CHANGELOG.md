
## 1.0.0 (2025-01-12)

### Major Changes

- **Complete rebuild from scratch** using Alpine Linux base images
- Migrated from Debian to Alpine Linux for smaller footprint and faster updates
- Implemented proper s6-overlay v3 supervision system
- Added comprehensive configuration options through Home Assistant UI

### Features

- ✨ **Alpine-based**: Now uses Alpine Linux with qbittorrent-nox package
- 🎯 **s6-overlay v3**: Proper process supervision and initialization
- 🔧 **Configurable**: Extensive options for ports, paths, connection limits, and scheduler
- 🔒 **SSL Support**: Optional HTTPS for Web UI
- ⏰ **Bandwidth Scheduler**: Schedule alternative speed limits
- 📁 **Auto-directory Creation**: Automatic creation of download and temp directories
- 🌐 **Multi-architecture**: Support for amd64, aarch64, armv7, armhf, and i386

### Configuration

New configuration schema with the following options:
- Web UI port configuration
- BitTorrent port configuration
- Download and temporary paths
- Connection limits (global and per-torrent)
- Upload limits (global and per-torrent)
- Alternative speed limits
- Bandwidth scheduler with time and day settings
- SSL/TLS support

### Breaking Changes

- Configuration format has changed - users will need to reconfigure their add-on
- Old configuration files are not automatically migrated
- Default paths changed from `/media` and `/config` to `/share/qbittorrent/`

### Technical Details

- Base Image: `ghcr.io/home-assistant/base:3.21`
- qBittorrent Version: Latest from Alpine repos (5.1.4+)
- Init System: s6-overlay v3
- Configuration: bashio-based initialization scripts
