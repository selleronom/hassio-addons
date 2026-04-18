# check=skip=SecretsUsedInArgOrEnv
ARG BUILD_FROM=ghcr.io/home-assistant/base-debian:trixie
ARG KARAKEEP_VERSION=0.31.0
ARG MEILISEARCH_VERSION=v1.41.0

FROM ghcr.io/karakeep-app/karakeep:${KARAKEEP_VERSION} AS karakeep

FROM ${BUILD_FROM}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG BUILD_ARCH=aarch64

ENV \
    DEBIAN_FRONTEND="noninteractive" \
    LANG="C.UTF-8" \
    HOME="/root" \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    S6_CMD_WAIT_FOR_SERVICES_MAXTIME=0 \
    S6_CMD_WAIT_FOR_SERVICES=1 \
    S6_SERVICES_GRACETIME=0 \
    S6_SERVICES_READYTIME=50 \
    TERM="xterm-256color" \
    PORT=3000 \
    DATA_DIR="/data" \
    MEILI_ADDR="http://127.0.0.1:7700" \
    MEILI_NO_ANALYTICS="true" \
    BROWSER_WEB_URL="http://127.0.0.1:9222" \
    NODE_ENV="production" \
    NEXT_TELEMETRY_DISABLED=1 \
    HOSTNAME="0.0.0.0"

# Install runtime dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
    chromium \
    curl \
    ghostscript \
    graphicsmagick \
    jq \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# Copy Karakeep application from upstream AIO image
COPY --from=karakeep /app /app
COPY --from=karakeep /db_migrations /db_migrations
COPY --from=karakeep /usr/local/bin/yt-dlp /usr/local/bin/yt-dlp
COPY --from=karakeep /usr/local/bin/monolith /usr/local/bin/monolith
COPY --from=karakeep /usr/local/lib/libjemalloc.so /usr/local/lib/libjemalloc.so

# Copy Node.js runtime from upstream
COPY --from=karakeep /usr/local/bin/node /usr/local/bin/node
COPY --from=karakeep /usr/local/lib/node_modules /usr/local/lib/node_modules
RUN ln -sf /usr/local/bin/node /usr/local/bin/nodejs

# Download Meilisearch binary (glibc build for Debian)
ARG MEILISEARCH_VERSION
ARG BUILD_ARCH
RUN case ${BUILD_ARCH} in \
    "aarch64"|"arm64") MEILI_ARCH=aarch64 ;; \
    "amd64"|"x86_64")  MEILI_ARCH=amd64   ;; \
    *) echo "Unsupported arch: ${BUILD_ARCH}" && exit 1 ;; \
    esac \
    && curl -fsSL "https://github.com/meilisearch/meilisearch/releases/download/${MEILISEARCH_VERSION}/meilisearch-linux-${MEILI_ARCH}" -o /usr/local/bin/meilisearch \
    && chmod +x /usr/local/bin/meilisearch

# Create required directories
RUN mkdir -p /data /data/meilisearch /data/assets /config

# Copy rootfs overlay (s6 services, helper scripts)
COPY rootfs/ /

# Make all scripts and service runs executable
RUN chmod +x \
    /usr/local/bin/load-env.sh \
    /etc/s6-overlay/s6-rc.d/init-config/run \
    /etc/s6-overlay/s6-rc.d/init-db-migration/run \
    /etc/s6-overlay/s6-rc.d/svc-meilisearch/run \
    /etc/s6-overlay/s6-rc.d/svc-chrome/run \
    /etc/s6-overlay/s6-rc.d/svc-web/run \
    /etc/s6-overlay/s6-rc.d/svc-workers/run

ARG BUILD_VERSION
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
LABEL \
    io.hass.type="addon" \
    org.opencontainers.image.title="Home Assistant App: Karakeep" \
    org.opencontainers.image.description="Bookmark manager for the data hoarder" \
    org.opencontainers.image.source="https://github.com/selleronom/hassio-addons" \
    org.opencontainers.image.licenses="MIT"
