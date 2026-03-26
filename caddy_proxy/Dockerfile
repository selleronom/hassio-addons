ARG BUILD_FROM=ghcr.io/home-assistant/base:3.23
FROM $BUILD_FROM

# Install packages
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    # renovate: datasource=repology depName=alpine_edge/caddy versioning=loose
    caddy=2.11.2-r0 \
    xcaddy

WORKDIR /src
RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/certmagic@master \
    --replace github.com/caddy-dns/cloudflare=github.com/ogerman/cloudflare@1bc23c9 \
    --output /usr/sbin/caddy
RUN apk del --no-cache xcaddy || true \
    && rm -rf /root/*

# Make sure the built binary is executable
RUN chmod +x /usr/sbin/caddy || true

# Copy rootfs contents
COPY rootfs /

WORKDIR /

LABEL \
    io.hass.type="addon" \
    org.opencontainers.image.title="Home Assistant App: Caddy Proxy Manager" \
    org.opencontainers.image.description="A reverse proxy using Caddy with Cloudflare DNS support" \
    org.opencontainers.image.source="https://github.com/selleronom/hassio-addons" \
    org.opencontainers.image.licenses="Apache License 2.0"
