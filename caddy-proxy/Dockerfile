ARG BUILD_FROM
FROM $BUILD_FROM

# Install packages
RUN apk add --no-cache caddy openssl

# Copy rootfs contents
COPY rootfs /

WORKDIR /