ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Install radarr from Alpine edge testing repository
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing \
    # main_package
    radarr

# Copy rootfs
COPY rootfs /

WORKDIR /
