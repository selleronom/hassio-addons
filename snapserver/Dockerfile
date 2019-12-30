ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
# hadolint ignore=DL3003
RUN apt-get update && apt-get -y install \
apt-transport-https \
gnupg2 \
libavahi-client3 \
libavahi-common3 \
libflac8 \
libogg0 \
libopus0 \
libvorbis0a \
libvorbisenc2 \
&& curl -s https://api.github.com/repos/badaix/snapcast/releases/latest | \
grep browser_download_url | \
grep snapserver | \
grep armhf | \
cut -d '"' -f 4 | \
xargs -I URL curl -L URL -o snapserver-latest.deb \
&& dpkg -i snapserver-latest.deb \
&& apt-get -f install \
&& curl -sSL https://dtcooper.github.io/raspotify/key.asc | apt-key add -v - \
&& echo 'deb https://dtcooper.github.io/raspotify raspotify main' | tee /etc/apt/sources.list.d/raspotify.list \
&& apt-get update \
&& apt-get install -y \
raspotify

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
