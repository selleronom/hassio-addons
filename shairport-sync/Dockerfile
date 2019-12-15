ARG BUILD_FROM=alpine
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

#Install snapcast
RUN apk add --update --no-cache \
--repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
shairport-sync \
jq \
bash \
dbus

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]