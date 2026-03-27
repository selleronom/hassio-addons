## Usage

This add-on runs `sendspin daemon` in the background, turning your Home Assistant device into a Sendspin audio target that can participate in multi-room audio.

### Auto-discovery

By default, Sendspin listens for servers on your local network via mDNS. No configuration is required — just start the add-on and it will advertise itself to any Sendspin server on the same LAN.

### Configuration

| Option        | Description                                                                                            |
| ------------- | ------------------------------------------------------------------------------------------------------ |
| `name`        | Friendly name shown on the Sendspin server (default: HA hostname)                                      |
| `url`         | Connect to a specific server, e.g. `ws://192.168.1.100:8927/sendspin`. Leave blank for auto-discovery. |
| `listen_port` | Port the daemon listens on for incoming server connections (default: 8927)                             |
| `log_level`   | Logging verbosity: `DEBUG`, `INFO`, `WARNING`, `ERROR`, or `CRITICAL` (default: `INFO`)                |

### Audio

Audio output is managed by Home Assistant. Use the **Audio** section in the add-on configuration panel to select the output device.

### Network

`host_network` is enabled so that mDNS multicast packets reach the add-on for server auto-discovery. If you always connect to a specific server via `url`, host networking is technically unnecessary but kept for simplicity.
