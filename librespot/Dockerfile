ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add bash librespot --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing

# Copy root filesystem
COPY rootfs /

LABEL \
    io.hass.version="VERSION" \
    io.hass.type="addon" \
    io.hass.arch="armhf|aarch64|i386|amd64"