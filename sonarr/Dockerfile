ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Install sonarr from Alpine edge testing repository
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing \
    # main_package
    sonarr

# Copy rootfs
COPY rootfs /

WORKDIR /
