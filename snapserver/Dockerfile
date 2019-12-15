ARG BUILD_FROM=alpine
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

#Install snapcast
RUN apk add --no-cache snapcast jq bash avahi avahi-dev avahi-compat-libdns_sd dbus

RUN mkdir -p /var/run/dbus

VOLUME /var/run/dbus
VOLUME /etc/avahi/services

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
