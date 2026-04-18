# CronJob Helm Chart

A generic Helm chart for creating one or more Kubernetes CronJobs from a shared base image and per-job overrides.

## Prerequisites

- Kubernetes 1.21+
- Helm 3+

## Installation

```bash
helm repo add tambovchanin https://tambovchanin.github.io/helm-charts
helm repo update
helm install my-cronjobs tambovchanin/cronjob
```

## Values

| Parameter | Description | Default |
| --- | --- | --- |
| `nameOverride` | Override chart name | `""` |
| `fullnameOverride` | Override full release name | `""` |
| `image.registry` | Default image registry | `docker.io` |
| `image.repository` | Default image repository | `busybox` |
| `image.tag` | Default image tag | `latest` |
| `image.pullPolicy` | Default image pull policy | `IfNotPresent` |
| `imagePullSecrets` | Image pull secrets | `[]` |
| `dockerConfigJson` | Optional `.dockerconfigjson` payload for private registry auth | `""` |
| `secrets` | Secrets mounted under `/secrets/<name>` | `{}` |
| `customConfigMap` | Existing ConfigMap mounted under `/configMaps/<name>` | `""` |
| `configMaps` | Inline ConfigMaps created by the chart | `{}` |
| `env` | Global environment variables injected into every job | `[]` |
| `jobs` | Map of CronJob definitions | `{}` |
| `serviceAccount.create` | Create a service account | `true` |
| `serviceAccount.annotations` | Service account annotations | `{}` |
| `serviceAccount.name` | Existing service account name | `""` |
| `podAnnotations` | Pod annotations inherited by jobs | `{}` |
| `podSecurityContext` | Pod-level security context | `{}` |
| `securityContext` | Container security context | `{}` |
| `resources` | Shared resource requests/limits | `{}` |
| `nodeSelector` | Node selector | `{}` |
| `tolerations` | Pod tolerations | `[]` |
| `affinity` | Pod affinity rules | `{}` |

### Job schema

Each item under `jobs.<name>` can override the shared defaults.

| Parameter | Description |
| --- | --- |
| `schedule` | Cron expression for the job |
| `command` | Container command array |
| `args` | Container arguments array |
| `image.registry` | Optional per-job registry override |
| `image.repository` | Optional per-job repository override |
| `image.tag` | Optional per-job tag override |
| `imagePullSecrets` | Optional per-job image pull secrets |
| `env` | Extra environment variables appended to the global `env` list |
| `podAnnotations` | Extra pod annotations for the job |
| `restartPolicy` | Pod restart policy, default `Never` |
| `concurrencyPolicy` | CronJob concurrency policy, default `Forbid` |
| `failedJobsHistoryLimit` | Retained failed jobs, default `1` |
| `successfulJobsHistoryLimit` | Retained successful jobs, default `1` |
| `startingDeadlineSeconds` | Optional starting deadline |
| `activeDeadlineSeconds` | Optional active deadline |
| `backoffLimit` | Job backoff limit |
| `completions` | Optional completions count |
| `parallelism` | Optional parallelism count |
| `ttlSecondsAfterFinished` | TTL after job completion |
| `suspend` | Suspend the CronJob |

## Configuration notes

- `customConfigMap` mounts one existing ConfigMap at `/configMaps/<name>`.
- Keys under `configMaps` are rendered as new ConfigMaps and mounted at `/configMaps/<name>`.
- Keys under `secrets` are rendered as new Secrets and mounted at `/secrets/<name>`.
- If `dockerConfigJson` is set, the chart can create a registry secret for image pulls.
