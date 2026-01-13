ARG BUILD_FROM
FROM $BUILD_FROM

# Setup base system
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    qbittorrent-nox=5.1.4-r1

# Copy root filesystem
COPY rootfs /

# Set working directory
WORKDIR /
