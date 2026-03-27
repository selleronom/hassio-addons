ARG BUILD_FROM=ghcr.io/home-assistant/base:3.23
FROM $BUILD_FROM

RUN apk add --no-cache \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing \
    # renovate: datasource=repology depName=alpine_edge_testing/cloudflared versioning=loose
    cloudflared=2026.3.0-r0

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
