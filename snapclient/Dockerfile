ARG BUILD_FROM=hassioaddons/base:8.0.0
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /root

#Install snapcast
RUN apk add snapcast-client@edge pulseaudio

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="snapclient" \
    io.hass.description="Snapcast server with librespot" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Selleronom" \
    org.label-schema.description="Snapcast server with librespot" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="snapclient" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/selleronom/hassio-addons/tree/master/snapclient" \
    org.label-schema.vendor="Selleronom add-ons"
