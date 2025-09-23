ARG BUILD_FROM
FROM $BUILD_FROM

# Install Syncthing (pinned) from Alpine edge community and base utilities
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    syncthing=2.0.9-r0 \
    && apk add --no-cache \
    tzdata \
    ca-certificates

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
