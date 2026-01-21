ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM

RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/main \
    icu-libs=78.1-r0 icu-data-full=78.1-r0

# Install Jellyfin
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
# main_package
    jellyfin=10.11.6-r0 \
    jellyfin-web=10.11.6-r0 \
    ffmpeg=8.0.1-r1

COPY rootfs /
