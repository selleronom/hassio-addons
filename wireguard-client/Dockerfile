ARG BUILD_FROM
FROM $BUILD_FROM

RUN \
    apk add --no-cache \
    wireguard-tools \
    ip6tables

# Copy root filesystem
COPY rootfs /