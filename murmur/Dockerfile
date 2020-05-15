ARG BUILD_FROM=hassioaddons/base:7.1.0
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /root

# Setup base
# hadolint ignore=DL3003
RUN apk add \
    avahi-compat-libdns_sd \
    busybox \
    libcap \
    libcrypto1.1 \
    libgcc \
    libprotobuf \
    libssl1.1 \
    libstdc++ \
    musl \
    qt5-qtbase \
    qt5-qtbase-sqlite \
    pwgen \
    libressl \
    murmur

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Murmur" \
    io.hass.description="Murmur server" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Selleronom" \
    org.label-schema.description="Murmur server" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Murmur" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/selleronom/hassio-addons/tree/master/Murmur" \
    org.label-schema.vendor="Selleronom add-ons"
