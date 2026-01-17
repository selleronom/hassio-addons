ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Install packages
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    caddy=2.10.2-r3 \
    openssl=3.5.4-r0

# Copy rootfs contents
COPY rootfs /

WORKDIR /
