ARG BUILD_FROM
FROM ${BUILD_FROM}

RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
    # main_package
    gitea=1.25.3-r1 \
    && \
    adduser -D -u 1000 git

COPY rootfs /
