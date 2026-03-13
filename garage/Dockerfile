ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM

RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
# main_package
    garage=2.1.0-r0 \
    wget=1.25.0-r2 \
# manual garage update
    && wget -q https://garagehq.deuxfleurs.fr/_releases/v2.2.0/aarch64-unknown-linux-musl/garage -O /usr/bin/garage \
    && chmod +x /usr/bin/garage

COPY rootfs /
