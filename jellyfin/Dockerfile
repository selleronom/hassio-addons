ARG BUILD_FROM=ghcr.io/home-assistant/base:3.23
FROM $BUILD_FROM

# Install Jellyfin
RUN apk add --no-cache \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/main \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    # renovate: datasource=repology depName=alpine_edge/jellyfin versioning=loose
    jellyfin-web=10.11.6-r0

COPY rootfs /

LABEL \
    io.hass.type="addon" \
    org.opencontainers.image.title="Home Assistant App: Jellyfin" \
    org.opencontainers.image.description="Jellyfin media server" \
    org.opencontainers.image.source="https://github.com/selleronom/hassio-addons" \
    org.opencontainers.image.licenses="Apache License 2.0"
