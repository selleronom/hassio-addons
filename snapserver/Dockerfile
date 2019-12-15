ARG BUILD_FROM=alpine
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

#Install snapcast
RUN apk add --no-cache snapcast jq bash avahi avahi-dev avahi-tools avahi-compat-libdns_sd dbus

ADD avahi-daemon.conf /etc/avahi/avahi-daemon.conf

# workaround to get dbus working, required for avahi to talk to dbus. This will be mounted
RUN mkdir -p /var/run/dbus
VOLUME /var/run/dbus

# login keys come in through a volume; we intend to log into root on this to run commands
#ENTRYPOINT avahi-daemon --no-drop-root

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
