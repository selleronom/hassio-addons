ARG BUILD_FROM
FROM $BUILD_FROM

WORKDIR /usr/src
ARG BUILD_ARCH

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Build libcec for HDMI-CEC
ARG LIBCEC_VERSION
RUN apk add --no-cache raspberrypi-dev raspberrypi-libs; \
    && apk add --no-cache \
        eudev-libs\
        p8-platform \
    && apk add --no-cache --virtual .build-dependencies \
        build-base \
        cmake \
        eudev-dev \
        git \
        p8-platform-dev \
        swig \
    && git clone --depth 1 -b libcec-${LIBCEC_VERSION} \
        "https://github.com/Pulse-Eight/libcec" /usr/src/libcec \
    && mkdir -p /usr/src/libcec/build \
    && cd /usr/src/libcec/build \
    && cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr/local ..; \
    && make -j$(nproc) \
    && make install \
    && apk del --no-cache .build-dependencies \
    && apk del --no-cache raspberrypi-dev; 

ENV LD_LIBRARY_PATH=/opt/vc/lib:${LD_LIBRARY_PATH}

# Copy data
COPY data/run.sh /

WORKDIR /
CMD [ "/run.sh" ]
