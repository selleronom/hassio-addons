ARG BUILD_FROM=hassioaddons/base:edge
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Add env
ENV LANG C.UTF-8

#Install snapcast
RUN apk add --update --no-cache \
--repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
snapcast \
jq \
bash \

#&& git clone https://github.com/librespot-org/librespot.git \
#&& cd librespot \
#&& cargo build --release \
#&& cp target/release/librespot /usr/bin/librespot

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
