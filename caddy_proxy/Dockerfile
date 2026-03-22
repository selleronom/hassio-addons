ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Install packages
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    # main_package
    caddy=2.11.2-r0 \
    xcaddy=0.4.5-r0

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
