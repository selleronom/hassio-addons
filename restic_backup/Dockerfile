ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM

RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
# main_package
    restic=0.18.1-r5

COPY rootfs /
