ARG BUILD_FROM=hassioaddons/base:8.0.0
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /root

# Setup base
# hadolint ignore=DL3003
RUN apk add searx@edge \
    && sed -i "s/127.0.0.1/0.0.0.0/g" /etc/searx/settings.yml

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Searx" \
    io.hass.description="Searx server" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Selleronom" \
    org.label-schema.description="Searx server" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Searx" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/selleronom/hassio-addons/tree/master/searx" \
    org.label-schema.vendor="Selleronom add-ons"
