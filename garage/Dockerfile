ARG BUILD_FROM=ghcr.io/home-assistant/base:3.23
FROM $BUILD_FROM

RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    # renovate: datasource=repology depName=alpine_edge/garage versioning=loose
    garage=2.2.0-r0 \
    wget

COPY rootfs /

LABEL \
    io.hass.type="addon" \
    org.opencontainers.image.title="Home Assistant App: Garage S3" \
    org.opencontainers.image.description="Lightweight S3-compatible storage server" \
    org.opencontainers.image.source="https://github.com/selleronom/hassio-addons" \
    org.opencontainers.image.licenses="Apache License 2.0"
