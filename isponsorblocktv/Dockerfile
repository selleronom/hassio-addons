ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM AS builder

# renovate: datasource=github-releases depName=dmunozv04/iSponsorBlockTV
ARG ISPONSORBLOCKTV_VERSION=v2.6.1

RUN apk add --no-cache \
    uv=0.10.4-r0 \
    git=2.53.0-r0 \
    gcc=15.2.0-r2 \
    musl-dev=1.2.5-r21

WORKDIR /app
# TODO: remove sed once upstream merges Python 3.14 fix
RUN git clone --branch ${ISPONSORBLOCKTV_VERSION} --depth 1 \
    https://github.com/dmunozv04/iSponsorBlockTV . \
    && sed -i 's/aiohttp==3.12.15/aiohttp==3.13.2/' requirements.txt

# uv sync reads pyproject.toml, creates .venv, installs all dependencies
RUN uv sync --no-dev --no-editable --index-strategy unsafe-best-match

# Optional: compile bytecode for faster startup
RUN uv run python -m compileall -b -f src \
    && find src -name "*.py" -type f -delete

# hadolint ignore=DL3006
FROM $BUILD_FROM

ENV iSPBTV_docker=True \
    iSPBTV_data_dir=data \
    TERM=xterm-256color \
    COLORTERM=truecolor \
    PATH="/app/.venv/bin:$PATH"

WORKDIR /app
COPY --from=builder /app/src ./
COPY --from=builder /app/.venv ./.venv
COPY rootfs/ /

HEALTHCHECK --interval=60s --timeout=10s --start-period=60s --retries=3 \
    CMD pgrep -f "python3.*main.pyc" > /dev/null || exit 1
