ARG BUILD_FROM=ghcr.io/home-assistant/base:3.23
FROM $BUILD_FROM

# Setup base system
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    # renovate: datasource=repology depName=alpine_edge/qbittorrent-nox versioning=loose
    qbittorrent-nox=5.1.4-r2

# Copy root filesystem
COPY rootfs /

LABEL \
    io.hass.type="addon" \
    org.opencontainers.image.title="Home Assistant App: qBittorrent" \
    org.opencontainers.image.description="A free and reliable P2P BitTorrent client" \
    org.opencontainers.image.source="https://github.com/selleronom/hassio-addons" \
    org.opencontainers.image.licenses="Apache License 2.0"
