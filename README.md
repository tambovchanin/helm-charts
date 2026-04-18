# tambovchanin Helm Charts

[![license](https://img.shields.io/github/license/tambovchanin/helm-charts.svg)](https://github.com/tambovchanin/helm-charts/blob/main/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/tambovchanin/helm-charts.svg)](https://github.com/tambovchanin/helm-charts)
[![GitHub Sponsor](https://img.shields.io/badge/github-sponsor-blue?logo=github)](https://github.com/sponsors/tambovchanin)
[![GitHub issues](https://img.shields.io/github/issues/tambovchanin/helm-charts.svg)](https://github.com/tambovchanin/helm-charts/issues)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/tambovchanin/helm-charts.svg)](https://github.com/tambovchanin/helm-charts/pulls)

A curated collection of Helm charts for Kubernetes workloads, ingress middleware, and storage primitives.

## Quick start

```bash
helm repo add tambovchanin https://tambovchanin.github.io/helm-charts
helm repo update
helm search repo tambovchanin
```

## Charts

| Chart | Description | Version | Documentation |
| --- | --- | --- | --- |
| [3xui](https://github.com/tambovchanin/helm-charts/tree/main/charts/3xui) | 3X-UI panel for Xray (Helm package: `xui`) | `0.3.0` | [README](https://github.com/tambovchanin/helm-charts/blob/main/charts/3xui/README.md) |
| [cronjob](https://github.com/tambovchanin/helm-charts/tree/main/charts/cronjob) | Generic CronJob templates | `0.0.1` | [README](https://github.com/tambovchanin/helm-charts/blob/main/charts/cronjob/README.md) |
| [crowdsec-bouncer-traefik](https://github.com/tambovchanin/helm-charts/tree/main/charts/crowdsec-bouncer-traefik) | CrowdSec Bouncer middleware for Traefik | `0.1.1` | [README](https://github.com/tambovchanin/helm-charts/blob/main/charts/crowdsec-bouncer-traefik/README.md) |
| [litellm](https://github.com/tambovchanin/helm-charts/tree/main/charts/litellm) | LiteLLM proxy with Bitnami-backed dependencies | `1.82.3` | [README](https://github.com/tambovchanin/helm-charts/blob/main/charts/litellm/README.md) |
| [pv](https://github.com/tambovchanin/helm-charts/tree/main/charts/pv) | PersistentVolume generator | `0.2.0` | [README](https://github.com/tambovchanin/helm-charts/blob/main/charts/pv/README.md) |
| [pvc](https://github.com/tambovchanin/helm-charts/tree/main/charts/pvc) | PersistentVolumeClaim generator | `0.2.0` | [README](https://github.com/tambovchanin/helm-charts/blob/main/charts/pvc/README.md) |
| [traefik-middleware](https://github.com/tambovchanin/helm-charts/tree/main/charts/traefik-middleware) | Traefik middleware and plugin configs | `0.1.0` | [README](https://github.com/tambovchanin/helm-charts/blob/main/charts/traefik-middleware/README.md) |

## Documentation

Each chart keeps its own README with installation notes and a values reference. The chart READMEs are the canonical source for chart-specific configuration.

## Contributing

Issues and pull requests are welcome. Please keep chart docs and values in sync when you change templates.
