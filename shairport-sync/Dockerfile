ARG BUILD_FROM=hassioaddons/base:7.1.0
# hadolint ignore=DL3006
FROM $BUILD_FROM

#Install snapcast
RUN apk add --update --no-cache \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    shairport-sync \
    && apk add alsa-plugins-pulse

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="AirPlay" \
    io.hass.description="AirPlay audio player" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Selleronom" \
    org.label-schema.description="AirPlay audio player" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="airplay" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/selleronom/hassio-addons/tree/master/shairport-sync" \
    org.label-schema.vendor="Selleronom add-ons"
