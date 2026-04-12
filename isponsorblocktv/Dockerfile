ARG BUILD_FROM=ghcr.io/home-assistant/base:3.23
FROM $BUILD_FROM

# renovate: datasource=pypi depName=isponsorblocktv
ARG ISPONSORBLOCKTV_VERSION=2.6.1

RUN apk add --no-cache uv \
    && uv tool install --python 3.13 --index-strategy unsafe-best-match \
    "isponsorblocktv==${ISPONSORBLOCKTV_VERSION}" \
    && apk del uv

ENV iSPBTV_docker=True \
    iSPBTV_data_dir=data \
    PYTHONUNBUFFERED=1 \
    PATH="/root/.local/bin:$PATH"

COPY rootfs/ /

LABEL \
    io.hass.type="addon" \
    org.opencontainers.image.title="Home Assistant App: iSponsorBlockTV" \
    org.opencontainers.image.description="Skip sponsor segments in YouTube videos on YouTube TV devices" \
    org.opencontainers.image.source="https://github.com/selleronom/hassio-addons" \
    org.opencontainers.image.licenses="Apache License 2.0"
