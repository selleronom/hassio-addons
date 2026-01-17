# Home Assistant Add-on: Sonarr

## Installation

1. Install this add-on
2. Start the add-on
3. Access Sonarr at `http://[HOST]:8989`
4. Complete the initial setup wizard

## Configuration

This add-on has no configuration options in Home Assistant. All configuration is done through Sonarr's web interface.

## Data Directories

The add-on has access to the following directories:

- `/share` - Shared directory (read/write)
- `/media` - Media directory (read/write)
- `/downloads` - Downloads directory (read/write)

You can configure Sonarr to use these directories for storing downloaded TV shows and monitoring series.

## Initial Setup

1. Open the Sonarr web interface at `http://[HOST]:8989`
2. Complete the setup wizard:
   - Configure your download client (qBittorrent, Transmission, etc.)
   - Add indexers for finding TV shows
   - Set up your root folders (use `/media` or `/share`)
   - Configure quality profiles

## Recommended Setup

### Download Client

If you're using qBittorrent from this repository:
- Host: `[homeassistant-ip]`
- Port: `8080`
- Username/Password: (as configured in qBittorrent)

### Root Folders

Add a root folder for your TV shows:
- Path: `/media/tv-shows` (create this in your media directory)

### Indexers

Add indexers to find TV shows:
- Go to Settings > Indexers
- Click the + button to add indexers
- Configure your preferred indexers (torznab, newznab, etc.)

## Integrating with Home Assistant

You can use the [Sonarr integration](https://www.home-assistant.io/integrations/sonarr/) to monitor and control Sonarr from Home Assistant:

```yaml
sonarr:
  host: localhost
  port: 8989
  api_key: YOUR_API_KEY
```

Get your API key from Sonarr's web interface: Settings > General > Security > API Key

## Support

For more information about Sonarr, visit:
- [Sonarr Documentation](https://wiki.servarr.com/sonarr)
- [Sonarr GitHub](https://github.com/Sonarr/Sonarr)
- [GitHub Issue Tracker](https://github.com/selleronom/hassio-addons/issues)
