ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Install Syncthing from Alpine edge community
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    syncthing=2.0.12-r0 \
    tzdata=2025c-r0 \
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
