ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

# Setup base
RUN apk add --no-cache unbound dns-root-hints bind-tools

# Copy data
COPY rootfs /

