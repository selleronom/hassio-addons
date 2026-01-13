ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    curl \
    openssl \
    sqlite \
    garage=2.1.0-r0

COPY rootfs /
