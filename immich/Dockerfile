# check=skip=SecretsUsedInArgOrEnv
ARG BUILD_FROM=ghcr.io/home-assistant/base-debian:trixie
ARG IMMICH_VERSION=v2.7.4
ARG POSTGRES_VERSION=pg18-v1.1.1
ARG VALKEY_VERSION=9.1-trixie

FROM ghcr.io/immich-app/immich-server:${IMMICH_VERSION} AS immich
FROM ghcr.io/tensorchord/vchord-postgres:${POSTGRES_VERSION} AS postgres
FROM valkey/valkey:${VALKEY_VERSION} AS valkey

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
    SERVER_PORT=2283 \
    PG_MAJOR=18 \
    PGDATA="/data/postgres" \
    POSTGRES_DB="immich" \
    POSTGRES_USER="immich" \
    POSTGRES_PASSWORD="immich" \
    POSTGRES_INITDB_ARGS="--data-checksum" \
    POSTGRES_SHARED_PRELOAD_LIBRARIES="vchord.so" \
    POSTGRES_SEARCH_PATH="public" \
    DB_URL="postgresql://immich:immich@127.0.0.1:5432/immich" \
    REDIS_HOSTNAME="127.0.0.1" \
    REDIS_PORT="6379" \
    REDIS_SOCKET="/var/run/redis/redis.sock" \
    IMMICH_MEDIA_LOCATION="/media/immich" \
    IMMICH_LOG_LEVEL="log" \
    XDG_CACHE_HOME="/data/cache"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
    jq \
    rsync \
    tzdata \
    gosu \
    && rm -rf /var/lib/apt/lists/*

# Runtime from upstream images (no source build in this Dockerfile)
COPY --from=immich /usr/src/app /usr/src/app
COPY --from=immich /build /build
COPY --from=immich /usr/bin/ffmpeg /usr/bin/ffmpeg
COPY --from=immich /usr/bin/ffprobe /usr/bin/ffprobe
COPY --from=immich /usr/local/bin /usr/local/bin
COPY --from=immich /usr/local/lib /usr/local/lib
COPY --from=immich /usr/lib /usr/lib
COPY --from=immich /etc/ld.so.conf.d /etc/ld.so.conf.d

COPY --from=postgres /usr/lib/postgresql /usr/lib/postgresql
COPY --from=postgres /usr/share/postgresql /usr/share/postgresql
COPY --from=postgres /usr/local/bin /usr/local/bin
COPY --from=postgres /usr/bin/psql /usr/bin/psql
COPY --from=postgres /usr/bin/pg_* /usr/bin/
COPY --from=postgres /etc/postgresql-common /etc/postgresql-common
COPY --from=postgres /usr/lib/aarch64-linux-gnu/libpq.so.5 /usr/lib/aarch64-linux-gnu/libpq.so.5
COPY --from=postgres /usr/lib/aarch64-linux-gnu/libpq.so.5.18 /usr/lib/aarch64-linux-gnu/libpq.so.5.18
COPY --from=postgres /lib/aarch64-linux-gnu/libicuuc.so.72 /lib/aarch64-linux-gnu/libicuuc.so.72
COPY --from=postgres /lib/aarch64-linux-gnu/libicudata.so.72 /lib/aarch64-linux-gnu/libicudata.so.72
COPY --from=postgres /lib/aarch64-linux-gnu/libicui18n.so.72 /lib/aarch64-linux-gnu/libicui18n.so.72
COPY --from=postgres /lib/aarch64-linux-gnu/libldap-2.5.so.0 /lib/aarch64-linux-gnu/libldap-2.5.so.0
COPY --from=postgres /lib/aarch64-linux-gnu/liblber-2.5.so.0 /lib/aarch64-linux-gnu/liblber-2.5.so.0
COPY --from=postgres /lib/aarch64-linux-gnu/libsasl2.so.2 /lib/aarch64-linux-gnu/libsasl2.so.2
COPY --from=postgres /lib/aarch64-linux-gnu/libgnutls.so.30 /lib/aarch64-linux-gnu/libgnutls.so.30
COPY --from=postgres /lib/aarch64-linux-gnu/libp11-kit.so.0 /lib/aarch64-linux-gnu/libp11-kit.so.0
COPY --from=postgres /lib/aarch64-linux-gnu/libidn2.so.0 /lib/aarch64-linux-gnu/libidn2.so.0
COPY --from=postgres /lib/aarch64-linux-gnu/libunistring.so.2 /lib/aarch64-linux-gnu/libunistring.so.2
COPY --from=postgres /lib/aarch64-linux-gnu/libtasn1.so.6 /lib/aarch64-linux-gnu/libtasn1.so.6
COPY --from=postgres /lib/aarch64-linux-gnu/libnettle.so.8 /lib/aarch64-linux-gnu/libnettle.so.8
COPY --from=postgres /lib/aarch64-linux-gnu/libhogweed.so.6 /lib/aarch64-linux-gnu/libhogweed.so.6
COPY --from=postgres /lib/aarch64-linux-gnu/libgmp.so.10 /lib/aarch64-linux-gnu/libgmp.so.10
COPY --from=postgres /lib/aarch64-linux-gnu/libkrb5.so.3 /lib/aarch64-linux-gnu/libkrb5.so.3
COPY --from=postgres /lib/aarch64-linux-gnu/libk5crypto.so.3 /lib/aarch64-linux-gnu/libk5crypto.so.3
COPY --from=postgres /lib/aarch64-linux-gnu/libcom_err.so.2 /lib/aarch64-linux-gnu/libcom_err.so.2
COPY --from=postgres /lib/aarch64-linux-gnu/libkrb5support.so.0 /lib/aarch64-linux-gnu/libkrb5support.so.0
COPY --from=postgres /lib/aarch64-linux-gnu/libkeyutils.so.1 /lib/aarch64-linux-gnu/libkeyutils.so.1
COPY --from=postgres /lib/aarch64-linux-gnu/libresolv.so.2 /lib/aarch64-linux-gnu/libresolv.so.2
COPY --from=postgres /lib/aarch64-linux-gnu/libxml2.so.2 /lib/aarch64-linux-gnu/libxml2.so.2
COPY --from=postgres /lib/aarch64-linux-gnu/libnuma.so.1 /lib/aarch64-linux-gnu/libnuma.so.1
COPY --from=postgres /lib/aarch64-linux-gnu/liburing.so.2 /lib/aarch64-linux-gnu/liburing.so.2

COPY --from=valkey /usr/local/bin /usr/local/bin
COPY --from=valkey /usr/local/lib/libvalkeylua.so /usr/local/lib/libvalkeylua.so
COPY --from=valkey /etc/passwd /tmp/passwd.valkey
COPY --from=valkey /etc/group /tmp/group.valkey

RUN set -eux; \
    getent group postgres >/dev/null || groupadd -r -g 900 postgres; \
    getent passwd postgres >/dev/null || useradd -r -u 900 -g postgres -d /var/lib/postgresql -s /usr/sbin/nologin postgres; \
    if ! getent group valkey >/dev/null; then \
    group_line="$(grep '^valkey:' /tmp/group.valkey || true)"; \
    if [ -n "$group_line" ]; then groupadd -r -g "$(echo "$group_line" | cut -d: -f3)" valkey; else groupadd -r -g 999 valkey; fi; \
    fi; \
    if ! getent passwd valkey >/dev/null; then \
    user_line="$(grep '^valkey:' /tmp/passwd.valkey || true)"; \
    if [ -n "$user_line" ]; then useradd -r -u "$(echo "$user_line" | cut -d: -f3)" -g valkey -d /data -s /usr/sbin/nologin valkey; else useradd -r -u 999 -g valkey -d /data -s /usr/sbin/nologin valkey; fi; \
    fi; \
    getent group immich >/dev/null || groupadd -r -g 911 immich; \
    getent passwd immich >/dev/null || useradd -r -u 911 -g immich -d /nonexistent -s /usr/sbin/nologin immich; \
    rm -f /tmp/passwd.valkey /tmp/group.valkey; \
    rm -rf /etc/s6-overlay/s6-rc.d/db-restore; \
    mkdir -p /data /data/postgres /config /defaults /media /var/run/postgresql /var/run/redis; \
    chown -R postgres:postgres /var/run/postgresql /data/postgres; \
    chown -R valkey:valkey /var/run/redis; \
    chmod 1777 /var/run/postgresql /var/run/redis; \
    ln -sf /usr/lib/postgresql/${PG_MAJOR}/bin/postgres /usr/local/bin/postgres; \
    ln -sf /usr/lib/postgresql/${PG_MAJOR}/bin/initdb /usr/local/bin/initdb; \
    ln -sf /usr/lib/postgresql/${PG_MAJOR}/bin/pg_ctl /usr/local/bin/pg_ctl; \
    ln -sf /usr/lib/postgresql/${PG_MAJOR}/bin/createdb /usr/local/bin/createdb; \
    ln -sf /usr/lib/postgresql/${PG_MAJOR}/bin/createuser /usr/local/bin/createuser

COPY rootfs/ /

RUN rm -rf /etc/s6-overlay/s6-rc.d/db-restore /etc/s6-overlay/s6-rc.d/init-nginx /etc/s6-overlay/s6-rc.d/svc-nginx

RUN chmod +x \
    /usr/local/bin/get-cpus.sh \
    /usr/local/bin/load-env.sh \
    /usr/local/bin/immich-server-wrapper.sh \
    /usr/local/bin/storage-folder-migration.sh \
    /etc/s6-overlay/s6-rc.d/init-config/run \
    /etc/s6-overlay/s6-rc.d/init-adduser/run \
    /etc/s6-overlay/s6-rc.d/init-config-immich/run \
    /etc/s6-overlay/s6-rc.d/init-postgres/run \
    /etc/s6-overlay/s6-rc.d/immich-media-folder-migration/run \
    /etc/s6-overlay/s6-rc.d/svc-postgres/run \
    /etc/s6-overlay/s6-rc.d/svc-redis/run \
    /etc/s6-overlay/s6-rc.d/svc-server/finish \
    /etc/s6-overlay/s6-rc.d/svc-server/run

RUN ldconfig

ARG BUILD_VERSION
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
LABEL \
    io.hass.type="addon" \
    org.opencontainers.image.title="Home Assistant App: Immich" \
    org.opencontainers.image.description="High performance self-hosted photo and video management solution" \
    org.opencontainers.image.source="https://github.com/selleronom/hassio-addons" \
    org.opencontainers.image.licenses="Apache License 2.0"
