ARG BUILD_FROM
FROM $BUILD_FROM

# renovate: datasource=repology depName=alpine_edge/garage
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    curl=8.18.0-r0 \
    openssl=3.5.4-r0 \
    sqlite=3.51.2-r0 \
    garage=2.1.0-r0

COPY rootfs /
