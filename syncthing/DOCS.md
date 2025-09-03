## Usage

Open the add-on and click OPEN WEB UI to access Syncthing via Ingress. The web UI is bound to 127.0.0.1:8384 inside the container and proxied by Home Assistant.

All Syncthing data resides in the add-on private storage and is included in add-on backups:

- /data/config: Syncthing configuration (config.xml, keys)
- /data/state: Syncthing internal state/index database
- /data/sync: Default root for any folders you create in Syncthing

No host folders are mapped into the container. This keeps data private to the add-on and ensures portability with backups.

If you need to interoperate with other add-ons or the host filesystem, consider exporting or backing up folders from Syncthing, or adapt this add-on locally to map specific host paths.

### Network ports

The Web UI is only available via Ingress; the 8384/tcp port remains disabled by default. Sync ports are enabled by default for LAN operation:

- 22000/tcp (Sync protocol)
- 21027/udp (Local discovery)

You can disable them from the add-on options if you require a strictly isolated node that only uses relays.

### Migration from older versions

Previous versions mapped host folders like `/config`, `/share`, or `/media`. This version uses only the add-on's private `/data` storage. After upgrading, Syncthing will initialize a fresh configuration unless you restore from a backup.

To migrate:

1) Create a Home Assistant add-on backup of the old Syncthing add-on and download it.
2) Extract the backup and locate Syncthing's configuration (config.xml, key files).
3) Stop this add-on and upload those files into `/data/config` of the add-on (e.g., using the official File Editor add-on or the SSH add-on entering the container).
4) Start the add-on.
