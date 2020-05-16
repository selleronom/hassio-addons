ARG BUILD_FROM=hassioaddons/debian-base:3.2.0
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /root

# Setup base
# hadolint ignore=DL3003
RUN apt-get update && apt-get install sudo -y && curl -sL https://dtcooper.github.io/raspotify/install.sh | sh

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Librespot" \
    io.hass.description="Spotify Connect piped to Snapcast" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Selleronom" \
    org.label-schema.description="librespot" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="librespot" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/selleronom/hassio-addons/tree/master/librespot" \
    org.label-schema.vendor="Selleronom add-ons"
