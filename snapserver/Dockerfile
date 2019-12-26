ARG BUILD_FROM=alpine:edge
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

#Install snapcast
RUN apk add --update \
build-base alsa-lib-dev libgcc musl git jq bash dbus

RUN apk add --update \
--repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
cargo rust snapcast

#&& git clone https://github.com/librespot-org/librespot.git \
#&& cd librespot \
#&& cargo build --release \
#&& cp target/release/librespot /usr/bin/librespot

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
