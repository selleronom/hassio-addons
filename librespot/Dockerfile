ARG BUILD_FROM=hassioaddons/base:7.1.0
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /root

# Setup base
# hadolint ignore=DL3003
RUN apk add --virtual .build-deps build-base git curl cargo portaudio-dev protobuf-dev pulseaudio-dev \
    && cd /root \
    && git clone https://github.com/librespot-org/librespot.git \
    && cd librespot \
    && cargo build --jobs $(grep -c ^processor /proc/cpuinfo) --release --no-default-features \
    && mv target/release/librespot /usr/local/bin \
    && cd / \
    && apk --purge del .build-deps \
    && apk add llvm-libunwind libgcc \
    && rm -rf /etc/ssl /var/cache/apk/* /lib/apk/db/* /root/librespot /root/.cargo

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
