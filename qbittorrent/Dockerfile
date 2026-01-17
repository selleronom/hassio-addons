ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Setup base system
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
# main_package
    qbittorrent-nox=5.1.4-r1

# Copy root filesystem
COPY rootfs /
