# Home Assistant Add-on: Radarr

## Installation

1. Install this add-on
2. Start the add-on
3. Access Radarr at `http://[HOST]:7878`
4. Complete the initial setup wizard

## Configuration

This add-on has no configuration options in Home Assistant. All configuration is done through Radarr's web interface.

## Data Directories

The add-on has access to the following directories:

- `/share` - Shared directory (read/write)
- `/media` - Media directory (read/write)
- `/downloads` - Downloads directory (read/write)

You can configure Radarr to use these directories for storing downloaded movies and monitoring your collection.

## Initial Setup

1. Open the Radarr web interface at `http://[HOST]:7878`
2. Complete the setup wizard:
   - Configure your download client (qBittorrent, Transmission, etc.)
   - Add indexers for finding movies
   - Set up your root folders (use `/media` or `/share`)
   - Configure quality profiles

## Recommended Setup

### Download Client

If you're using qBittorrent from this repository:
- Host: `[homeassistant-ip]`
- Port: `8080`
- Username/Password: (as configured in qBittorrent)

### Root Folders

Add a root folder for your movies:
- Path: `/media/movies` (create this in your media directory)

### Indexers

Add indexers to find movies:
- Go to Settings > Indexers
- Click the + button to add indexers
- Configure your preferred indexers (torznab, newznab, etc.)

## Integrating with Home Assistant

You can use the [Radarr integration](https://www.home-assistant.io/integrations/radarr/) to monitor and control Radarr from Home Assistant:

```yaml
radarr:
  host: localhost
  port: 7878
  api_key: YOUR_API_KEY
```

Get your API key from Radarr's web interface: Settings > General > Security > API Key

## Quality Profiles

Radarr comes with several quality profiles:
- Any - Downloads any available quality
- SD - Standard definition only
- HD-720p - 720p and below
- HD-1080p - 1080p and below
- Ultra-HD - 4K/2160p
- HD - Bluray-720p - High quality 720p
- HD - Bluray-1080p - High quality 1080p

You can customize these or create your own profiles in Settings > Profiles.

## Support

For more information about Radarr, visit:
- [Radarr Documentation](https://wiki.servarr.com/radarr)
- [Radarr GitHub](https://github.com/Radarr/Radarr)
- [GitHub Issue Tracker](https://github.com/selleronom/hassio-addons/issues)
