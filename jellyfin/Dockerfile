ARG BUILD_FROM
FROM $BUILD_FROM

# Install Jellyfin and hardware acceleration dependencies
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    jellyfin=10.11.5-r0 \
    jellyfin-web=10.11.5-r0 \
    ffmpeg \
    mesa-va-gallium \
    libva \
    libva-utils

COPY rootfs /
