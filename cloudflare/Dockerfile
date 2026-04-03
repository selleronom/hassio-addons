ARG BUILD_FROM=ghcr.io/home-assistant/base:3.23
FROM $BUILD_FROM

# renovate: datasource=github-releases depName=cloudflare/cloudflared
ARG CLOUDFLARED_VERSION=2026.3.0
RUN apk add --no-cache \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing \
    cloudflared=${CLOUDFLARED_VERSION}-r0

COPY rootfs /
RUN chmod +x /etc/s6-overlay/s6-rc.d/cloudflared/run

ENTRYPOINT ["/init"]
CMD []

LABEL \
    io.hass.type="addon" \
    org.opencontainers.image.title="Home Assistant Add-on: Cloudflared" \
    org.opencontainers.image.description="Cloudflare Tunnel client — connect your Home Assistant without opening ports" \
    org.opencontainers.image.source="https://github.com/selleronom/hassio-addons" \
    org.opencontainers.image.licenses="Apache License 2.0"
