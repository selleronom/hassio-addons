ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Install Jellyfin and hardware acceleration dependencies
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
# main_package
    jellyfin=10.11.5-r0 \
    jellyfin-web=10.11.5-r0

COPY rootfs /
