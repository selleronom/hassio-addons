ARG BUILD_FROM=ghcr.io/home-assistant/base:3.23
FROM $BUILD_FROM

# Install Syncthing from Alpine edge community
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
# main_package
    syncthing=2.0.15-r0 \
    tzdata=2026a-r0 \
    ca-certificates=20251003-r0

COPY root /
# Ensure s6 services are executable
RUN chmod +x /etc/s6-overlay/s6-rc.d/syncthing/run \
    && chmod +x /etc/s6-overlay/s6-rc.d/syncthing-setup/run

# Use add-on private persistent storage exclusively
ENV HOME=/data \
    STCONFDIR=/data/config \
    STDATADIR=/data/state \
    STNODEFAULTFOLDER=1 \
    STNORESTART=1 \
    STNOUPGRADE=1

ENTRYPOINT [ "/init" ]
CMD []

LABEL \
    io.hass.type="addon" \
    org.opencontainers.image.title="Home Assistant App: Syncthing" \
    org.opencontainers.image.description="Continuous file synchronization program" \
    org.opencontainers.image.source="https://github.com/selleronom/hassio-addons" \
    org.opencontainers.image.licenses="Apache License 2.0"
