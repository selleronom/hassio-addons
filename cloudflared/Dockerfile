ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Install cloudflared from Alpine edge testing repository
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing \
    # main_package
    cloudflared=2024.12.1-r11

# Copy rootfs
COPY rootfs /

WORKDIR /
