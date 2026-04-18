# Home Assistant Add-on: Karakeep

This add-on runs Karakeep (bookmark manager), Meilisearch, and headless Chromium
in a single container on Home Assistant using s6 to supervise all services.

## Build Model

This add-on is runtime-only:

- One Dockerfile
- No source compilation in the add-on Dockerfile
- Multi-stage runtime assembly from upstream images

## Scope

- Architecture: aarch64, amd64
- All-in-one: Karakeep web + workers + Meilisearch + Chromium

## Upstream Runtime Images

- `ghcr.io/karakeep-app/karakeep` — Karakeep application
- `getmeili/meilisearch` — Full-text search engine
- `ghcr.io/home-assistant/base-debian` — Home Assistant base
- Chromium via Debian apt packages
