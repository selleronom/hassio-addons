# Home Assistant Add-on: Karakeep

## Overview

This add-on runs Karakeep, Meilisearch, and headless Chromium in one container using s6.

Karakeep is a bookmark manager for the data hoarder — save links, notes, and images
with automatic AI tagging, full-text search, and web archiving.

## Configuration

### Required

- `NEXTAUTH_SECRET`: Generate with `openssl rand -base64 36`
- `MEILI_MASTER_KEY`: Generate with `openssl rand -base64 36 | tr -dc 'A-Za-z0-9'`

### Reverse Proxy

- `NEXTAUTH_URL`: Set to your external URL (e.g. `https://karakeep.example.com`)
  when behind a reverse proxy. Required for correct redirects and OAuth callbacks.

### AI Tagging

Set `OPENAI_API_KEY` for OpenAI, or `OLLAMA_BASE_URL` for local inference.
When using Ollama, change `INFERENCE_TEXT_MODEL` and `INFERENCE_IMAGE_MODEL`
to models available on your Ollama instance.

### Extra Environment Variables

Use the `env_vars` list to pass any Karakeep environment variable not directly
exposed in the UI. For example, to configure OAuth:

```yaml
env_vars:
  - key: OAUTH_WELLKNOWN_URL
    value: "https://auth.example.com/.well-known/openid-configuration"
  - key: OAUTH_CLIENT_ID
    value: "karakeep"
  - key: OAUTH_CLIENT_SECRET
    value: "your-secret"
```

See all available variables at: https://docs.karakeep.app/configuration/

## Ports

- `3000/tcp`: Karakeep web UI (disabled by default)

Meilisearch (7700) and Chromium (9222) run internally and are not exposed.

## Notes

- Meilisearch data is stored under `/data/meilisearch`.
- SQLite database and assets are stored under `/data`.
- Use Home Assistant backups for data protection.
- Memory-tuned for shared environments: all worker counts default to 1.
