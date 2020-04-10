ARG BUILD_FROM=hassioaddons/base:latest
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /root
# nix 0.10.0 fix; https://github.com/librespot-org/librespot/issues/454
COPY Cargo.toml-upd /tmp/Cargo.toml

# Setup base
# hadolint ignore=DL3003
RUN apk add --virtual .build-deps build-base git curl cargo portaudio-dev protobuf-dev pulseaudio-dev \
    && cd /root \
    && git clone https://github.com/librespot-org/librespot.git \
    && cd librespot \
    && cp /tmp/Cargo.toml connect/ \
    && cargo build --jobs $(grep -c ^processor /proc/cpuinfo) --release --no-default-features \
    && mv target/release/librespot /usr/local/bin \
    && cd / \
    && apk --purge del .build-deps \
    && apk add llvm-libunwind snapcast-server@edge \
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
    io.hass.name="Snapserver" \
    io.hass.description="Snapcast server with librespot" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Selleronom" \
    org.label-schema.description="Snapcast server with librespot" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Snapserver" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/selleronom/hassio-addons/tree/master/snapserver" \
    org.label-schema.vendor="Selleronom add-ons"
