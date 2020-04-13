ARG BUILD_FROM=hassioaddons/debian-base:3.1.0
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /root

#Install snapcast
RUN apt-get update && apt-get -y upgrade \
    && apt-get -y install wget gnupg \
    && wget -O - https://download.gluster.org/pub/gluster/glusterfs/7/rsa.pub | apt-key add - \
    && echo deb [arch=aarch64] https://download.gluster.org/pub/gluster/glusterfs/7/LATEST/Debian/buster/amd64/apt buster main > /etc/apt/sources.list.d/gluster.list \
    && apt-get update \
    && apt-get install -y glusterfs-server

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="gluster" \
    io.hass.description="Gluster server" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Selleronom" \
    org.label-schema.description="Gluster server" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="gluster" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/selleronom/hassio-addons/gluster" \
    org.label-schema.vendor="Selleronom add-ons"
