ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM

RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    garage=2.1.0-r0 \
    curl=8.18.0-r0 \
    openssl=3.5.4-r0 \
    sqlite=3.51.2-r0

COPY rootfs /
