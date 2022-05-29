ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache snapcast 

# Copy root filesystem
COPY rootfs /

LABEL \
    io.hass.version="VERSION" \
    io.hass.type="addon" \
    io.hass.arch="armhf|aarch64|i386|amd64"