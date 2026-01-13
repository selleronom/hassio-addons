# Home Assistant Add-on: qBittorrent

qBittorrent is a free and reliable P2P BitTorrent client.

## Installation

Follow these steps to get the add-on installed on your system:

1. Navigate in your Home Assistant frontend to **Settings** → **Add-ons** → **Add-on Store**.
2. Add the repository: `https://github.com/Selleronom/hassio-addons`
3. Find the "qBittorrent" add-on and click it.
4. Click on the "INSTALL" button.

## How to use

1. Configure the add-on options according to your needs (see configuration section below)
2. Start the add-on
3. Check the logs of the add-on to see if everything went well
4. Open the Web UI using the "OPEN WEB UI" button or navigate to `http://homeassistant.local:8080`

## Configuration

Add-on configuration example:

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

### Option: `webui_port` (required)

The port on which the qBittorrent Web UI will be accessible.

Default: `8080`

### Option: `bt_port` (required)

The port used for BitTorrent protocol connections (both TCP and UDP).

Default: `6881`

### Option: `save_path` (required)

The directory path where completed downloads will be saved.

Default: `/share/qbittorrent/downloads`

**Note**: The directory will be automatically created if it doesn't exist.

### Option: `temp_path` (required)

The directory path for incomplete/temporary downloads.

Default: `/share/qbittorrent/temp`

**Note**: The directory will be automatically created if it doesn't exist.

### Option: `max_connec` (required)

Maximum number of global connections.

Default: `500`

### Option: `max_connec_per_torrent` (required)

Maximum number of connections per torrent.

Default: `100`

### Option: `max_uploads` (required)

Maximum number of global upload slots.

Default: `15`

### Option: `max_uploads_per_torrent` (required)

Maximum number of upload slots per torrent.

Default: `4`

### Option: `limit_utp_rate` (required)

Whether to apply rate limit to uTP protocol.

Default: `true`

### Option: `limit_tcp_overhead` (required)

Whether to include TCP and IP overhead in rate limits.

Default: `false`

### Option: `alt_dl_limit` (required)

Alternative download speed limit in KiB/s (used when scheduler is active).

Default: `10240` (10 MB/s)

### Option: `alt_up_limit` (required)

Alternative upload speed limit in KiB/s (used when scheduler is active).

Default: `10240` (10 MB/s)

### Option: `scheduler_enabled` (required)

Enable bandwidth scheduler to automatically switch between normal and alternative speed limits based on a schedule.

Default: `false`

### Option: `schedule_from_hour` (optional)

Hour when the scheduler should start (0-23). Only used when `scheduler_enabled` is `true`.

### Option: `schedule_from_min` (optional)

Minute when the scheduler should start (0-59). Only used when `scheduler_enabled` is `true`.

### Option: `schedule_to_hour` (optional)

Hour when the scheduler should end (0-23). Only used when `scheduler_enabled` is `true`.

### Option: `schedule_to_min` (optional)

Minute when the scheduler should end (0-59). Only used when `scheduler_enabled` is `true`.

### Option: `scheduler_days` (optional)

Days when the scheduler is active:
- 0: Every day
- 1: Every weekday
- 2: Every weekend
- 3: Monday
- 4: Tuesday
- 5: Wednesday
- 6: Thursday
- 7: Friday

Default: `0` (Every day)

### Option: `ssl_enabled` (required)

Enable HTTPS for the Web UI.

Default: `false`

### Option: `ssl_cert` (optional)

Path to your SSL certificate file. Required when `ssl_enabled` is `true`.

Example: `/ssl/fullchain.pem`

### Option: `ssl_key` (optional)

Path to your SSL key file. Required when `ssl_enabled` is `true`.

Example: `/ssl/privkey.pem`

## Default Credentials

The default login credentials for qBittorrent are:

- **Username**: `admin`
- **Password**: `adminadmin`

**Important**: Please change the default password immediately after your first login for security reasons!

To change the password:
1. Log in to the Web UI
2. Go to Tools → Options → Web UI
3. Change the password under "Authentication"

## Known Issues and Limitations

- The add-on uses the Alpine Linux `qbittorrent-nox` package
- Configuration changes require an add-on restart to take effect
- Initial startup may take a few seconds while configuration is being generated

## Support

Got questions or problems?

You can open an issue on GitHub:
https://github.com/Selleronom/hassio-addons/issues

## Authors & Contributors

The original setup of this repository is by [Erik Montnemery](https://github.com/Selleronom).

## License

MIT License

Copyright (c) 2025 Erik Montnemery

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE. add-on

## How to use
