# Jellyfin

Jellyfin media server with hardware acceleration support for Raspberry Pi 5.

## Hardware Acceleration

The addon supports H.265/HEVC hardware decoding on Raspberry Pi 5 at 4Kp60.

### Configuration

After starting the addon, configure hardware acceleration in Jellyfin:

1. Navigate to **Dashboard → Playback**
2. Under **Hardware acceleration**, select **Video Acceleration API (VAAPI)** or **V4L2**
3. Enable **Hardware decoding** for H.265/HEVC codecs

### Important Notes

- **Raspberry Pi 5**: Only H.265/HEVC has hardware decoding - H.264 uses software decoding
- **Performance**: Can handle 2-3 simultaneous 4K HEVC streams with hardware acceleration
- **Transcoding**: Hardware acceleration applies to decoding only - encoding is software-based

## Configuration

- `log_level`: Jellyfin log level (info, debug, warning, error)
- `cache_size`: Cache size (default: 1G)
- `enable_hwaccel`: Enable hardware acceleration device passthrough
