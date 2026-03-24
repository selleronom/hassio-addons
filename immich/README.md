# Home Assistant Add-on: Immich (All-in-One)

This add-on runs Immich in a single container on Home Assistant using s6 to supervise:

- Immich server
- PostgreSQL (VectorChord image runtime)
- Valkey

## Build Model

This add-on is intentionally runtime-only:

- one Dockerfile
- no source compilation in the add-on Dockerfile
- multi-stage runtime assembly from upstream images

## Scope

- Architecture: aarch64 only
- Machine learning sidecar: not included in this variant

## Upstream Runtime Images

- `ghcr.io/immich-app/immich-server:v2.6.2`
- `ghcr.io/tensorchord/vchord-postgres:pg18-v1.1.1`
- `valkey/valkey:9.1-trixie`
- `ghcr.io/home-assistant/aarch64-base-debian:trixie`
