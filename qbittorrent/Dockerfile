ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Setup base system
# renovate: datasource=repology depName=alpine_edge/qbittorrent-nox
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    qbittorrent-nox==5.1.4-r1

# Copy root filesystem
COPY rootfs /
