# Home Assistant Add-on: Immich

## Overview

This add-on runs Immich, PostgreSQL and Valkey in one container using s6.

This project variant is:

- aarch64 only
- machine-learning sidecar excluded
- runtime-only Dockerfile (no source build steps)

## Configuration

- `IMMICH_MEDIA_LOCATION`: media path inside `/media` or `/config/library`
- `IMMICH_MACHINE_LEARNING_ENABLED`: enable external ML integration (default: false)
- `IMMICH_MACHINE_LEARNING_URL`: URL for external ML host (default: `http://immich-machine-learning:3003`)
- `clean_redis`: removes persisted Valkey dump before startup

## Ports

- `2283/tcp`: Immich server (disabled by default)
- `5432/tcp`: PostgreSQL (disabled by default)
- `6379/tcp`: Valkey (disabled by default)

## Notes

- DB and cache are local to the add-on container.
- Use Home Assistant backups and Immich backup strategy as needed.
