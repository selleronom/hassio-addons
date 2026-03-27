ARG BUILD_FROM=ghcr.io/home-assistant/base-debian:trixie
FROM $BUILD_FROM

ENV PATH="/root/.local/bin:${PATH}"

# renovate: datasource=pypi depName=sendspin
ARG SENDSPIN_VERSION=5.9.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    curl \
    libportaudio2 \
    libpulse0 \
    libasound2-plugins \
    && rm -rf /var/lib/apt/lists/* \
    && curl -LsSf https://astral.sh/uv/install.sh | sh \
    && uv tool install sendspin==${SENDSPIN_VERSION}

COPY rootfs /
RUN chmod +x /etc/s6-overlay/s6-rc.d/sendspin/run

ENTRYPOINT [ "/init" ]
CMD []

LABEL \
    io.hass.type="addon" \
    org.opencontainers.image.title="Home Assistant Add-on: Sendspin" \
    org.opencontainers.image.description="Multi-room audio client using the Sendspin protocol" \
    org.opencontainers.image.source="https://github.com/selleronom/hassio-addons" \
    org.opencontainers.image.licenses="Apache License 2.0"
