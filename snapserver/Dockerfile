ARG BUILD_FROM=debian:latest
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

#Install snapcast
RUN apt update && apt install snapserver
RUN curl -sL https://dtcooper.github.io/raspotify/install.sh | sh

#&& git clone https://github.com/librespot-org/librespot.git \
#&& cd librespot \
#&& cargo build --release \
#&& cp target/release/librespot /usr/bin/librespot

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
