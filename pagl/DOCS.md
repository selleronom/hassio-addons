# Home Assistant Add-on: PAGL Stack

## Overview

All-in-one monitoring stack running **Prometheus**, **Alertmanager**, **Grafana**, and **Loki** inside a single add-on container. All configuration is managed through the Home Assistant add-on options — no config files on disk to maintain.

## How it works

On every start the add-on reads its options and generates:

- `/etc/prometheus/prometheus.yml` — scrape targets, intervals, alerting
- `/etc/prometheus/rules/addon_alerts.yml` — alerting rules
- `/etc/alertmanager/alertmanager.yml` — webhook receivers
- `/etc/loki/loki.yml` — log aggregation settings
- `/etc/grafana/grafana.ini` — server & auth settings
- Grafana datasource provisioning (auto-connects Prometheus, Alertmanager, and Loki)

All persistent data (TSDB, alert state, Grafana dashboards/plugins) is stored under `/data/` and survives add-on restarts.

## Ports

| Port | Service      | Description                  |
| ---- | ------------ | ---------------------------- |
| 3000 | Grafana      | Dashboard UI (default webui) |
| 3100 | Loki         | Log aggregation API          |
| 9090 | Prometheus   | Query UI & API               |
| 9093 | Alertmanager | Alert management UI          |

Map the ports you need in the add-on **Network** configuration.

## Configuration

### `log_level`

Log verbosity for all services. One of `debug`, `info`, `warn`, `error`.

### `scrape_interval` / `evaluation_interval`

How often Prometheus scrapes targets and evaluates alert rules. Use Go duration format: `15s`, `1m`, `5m`.

### `loki_retention_period`

How long Loki retains log data. Default `720h` (30 days). Use Go duration format: `168h` (7 days), `720h` (30 days).

### `grafana_admin_user` / `grafana_admin_password`

Credentials for the Grafana admin account. **Change the default password.**

### `ha_scrape_target`

When `true`, Prometheus automatically scrapes Home Assistant's built-in `/api/prometheus` endpoint using the Supervisor token. You must enable the **Prometheus** integration in Home Assistant first (Settings → Devices & Services → Add Integration → Prometheus).

### `scrape_targets`

Additional Prometheus scrape targets. Each entry:

| Field             | Required | Description                              |
| ----------------- | -------- | ---------------------------------------- |
| `job_name`        | yes      | Unique name for the scrape job           |
| `target`          | yes      | `host:port` to scrape                    |
| `metrics_path`    | no       | Path to metrics (default `/metrics`)     |
| `scrape_interval` | no       | Override global interval for this target |

Example:

```yaml
scrape_targets:
  - job_name: node_exporter
    target: 192.168.1.100:9100
  - job_name: cadvisor
    target: 192.168.1.100:8080
    metrics_path: /metrics
    scrape_interval: 30s
```

### `alert_rules`

Prometheus alerting rules. Each entry:

| Field      | Required | Description                        |
| ---------- | -------- | ---------------------------------- |
| `name`     | yes      | Alert name                         |
| `expr`     | yes      | PromQL expression                  |
| `for`      | no       | Duration before firing (e.g. `5m`) |
| `severity` | no       | Label value (default `warning`)    |
| `summary`  | no       | Annotation text                    |

Example:

```yaml
alert_rules:
  - name: HighMemoryUsage
    expr: process_resident_memory_bytes > 1e9
    for: 5m
    severity: critical
    summary: "Memory usage exceeded 1GB"
```

### `alertmanager_webhook_urls`

List of webhook URLs that receive alert notifications. Useful for triggering Home Assistant automations:

```yaml
alertmanager_webhook_urls:
  - http://homeassistant.local.hass.io:8123/api/webhook/my-prom-alerts
```

## Backup

The add-on uses **cold** backups. Prometheus WAL files are excluded from backups to keep snapshot sizes manageable.

## Loki

Loki runs as a single-binary instance with filesystem storage (no external object store needed). Logs can be pushed to `http://<addon-host>:3100/loki/api/v1/push` using any compatible agent (Promtail, Alloy, Fluentd, etc.).

- **Storage**: local filesystem under `/data/loki/`
- **Schema**: TSDB store with v13 schema
- **Auth**: disabled (single-tenant mode)
- **Retention**: controlled by the `loki_retention_period` option
