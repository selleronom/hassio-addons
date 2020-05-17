ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /root

# Install shairport-sync
# hadolint ignore=DL3003
RUN apk add --virtual .build-deps alpine-sdk \
    autoconf \
    automake \
    libtool \
    alsa-lib-dev \
    libdaemon-dev \
    popt-dev \
    libressl-dev \
    soxr-dev \
    avahi-dev \
    libconfig-dev \
    && git clone https://github.com/mikebrady/shairport-sync.git \
    && cd shairport-sync \
    && autoreconf -i -f \
    && ./configure --with-pipe --with-avahi --with-ssl=openssl --with-metadata \
    && make \
    && make install \
    && apk --purge del .build-deps \
    && apk add \
    dbus \
    alsa-lib \
    libdaemon \
    popt \
    libressl \
    soxr \
    avahi \
    libconfig \
    && rm -rf \
    /etc/ssl \
    /var/cache/apk/* \
    /lib/apk/db/* \
    /root/shairport-sync \
    && cd /root

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
    io.hass.description="AirPlay audio player piped to snapserver" \
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
