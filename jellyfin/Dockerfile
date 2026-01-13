ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Install Jellyfin and hardware acceleration dependencies
# renovate: datasource=repology depName=alpine_edge/jellyfin
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    jellyfin=10.11.5-r0 \
    jellyfin-web=10.11.5-r0 \
    ffmpeg=8.0.1-r1 \
    mesa-va-gallium=25.2.7-r3 \
    libva=2.22.0-r1 \
    libva-utils=

COPY rootfs /
