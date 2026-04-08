ARG BUILD_FROM=ghcr.io/home-assistant/base:3.23
FROM $BUILD_FROM

# Install Prometheus, Alertmanager, Grafana & Loki from Alpine edge community
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    # renovate: datasource=repology depName=alpine_edge/prometheus versioning=loose
    prometheus=3.5.1-r2 \
    # renovate: datasource=repology depName=alpine_edge/alertmanager versioning=loose
    alertmanager=0.31.1-r1 \
    # renovate: datasource=repology depName=alpine_edge/grafana versioning=loose
    grafana=12.4.1-r0 \
    # renovate: datasource=repology depName=alpine_edge/loki versioning=loose
    loki=3.7.1-r0

# Copy root filesystem
COPY rootfs /

LABEL \
    io.hass.type="addon" \
    org.opencontainers.image.title="Home Assistant App: PAGL Stack" \
    org.opencontainers.image.description="Prometheus, Alertmanager, Grafana & Loki monitoring stack" \
    org.opencontainers.image.source="https://github.com/selleronom/hassio-addons" \
    org.opencontainers.image.licenses="Apache License 2.0"
