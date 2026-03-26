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

- `ghcr.io/immich-app/immich-server`
- `ghcr.io/tensorchord/vchord-postgres`
- `valkey/valkey`
- `ghcr.io/home-assistant/aarch64-base-debian`
