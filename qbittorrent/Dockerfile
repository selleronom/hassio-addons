ARG BUILD_FROM
FROM $BUILD_FROM

RUN apt update && apt install -y \
    qbittorrent-nox

# Copy root filesystem
COPY rootfs /
