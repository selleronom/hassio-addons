ARG BUILD_FROM=hassioaddons/bitwarden-aarch64
###############################################################################
# Build the actual add-on.
###############################################################################
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# add Gluster
# hadolint ignore=DL3009
RUN \
    apt-get update && apt-get install -y wget gnupg \
    && wget -O - https://download.gluster.org/pub/gluster/glusterfs/7/rsa.pub | apt-key add - \
    && echo deb [arch=amd64] https://download.gluster.org/pub/gluster/glusterfs/7/LATEST/Debian/buster/amd64/apt buster main > /etc/apt/sources.list.d/gluster.list \
    && apt-get update && apt-get install -y glusterfs-client

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Bitwarden RS" \
    io.hass.description="Open source password management solution." \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.label-schema.description="Open source password management solution." \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Bitwarden RS" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://community.home-assistant.io/t/home-assistant-community-add-on-bitwarden-rs/115573?u=frenck" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-bitwarden/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-bitwarden" \
    org.label-schema.vendor="Home Assistant Community Add-ons"
