ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Install Jellyfin
RUN apk add --no-cache \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/main \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    # main_package
    jellyfin-web=10.11.6-r0

COPY rootfs /
