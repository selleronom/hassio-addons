ARG BUILD_FROM=hassioaddons/base:7.1.0
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /root

# Setup base
# hadolint ignore=DL3003
RUN apk add bash snapcast-server@edge

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Snapserver" \
    io.hass.description="Snapcast server" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Selleronom" \
    org.label-schema.description="Snapcast server" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Snapserver" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/selleronom/hassio-addons/tree/master/snapserver" \
    org.label-schema.vendor="Selleronom add-ons"
