ARG BUILD_FROM
FROM $BUILD_FROM

# Install packages
RUN apk add --no-cache caddy==2.10.0-r3 --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    && apk add --no-cache \
    openssl

# Copy rootfs contents
COPY rootfs /

WORKDIR /
