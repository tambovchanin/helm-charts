# 3X-UI / xui Helm Chart

A Helm chart for deploying the 3X-UI panel with optional Traefik TCP exposure for Xray.

The Helm package name is `xui`.

## Prerequisites

- Kubernetes 1.21+
- Helm 3+
- Traefik when `xray.enabled=true`

## Installation

```bash
helm repo add tambovchanin https://tambovchanin.github.io/helm-charts
helm repo update
helm install my-3xui tambovchanin/xui
```

## Values

| Parameter | Description | Default |
| --- | --- | --- |
| `replicaCount` | Number of application replicas | `1` |
| `image.repository` | Container image repository | `ghcr.io/mhsanaei/3x-ui` |
| `image.tag` | Container image tag | `latest` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `imagePullSecrets` | Optional image pull secrets | `[]` |
| `nameOverride` | Override chart name | `""` |
| `fullnameOverride` | Override full release name | `""` |
| `serviceAccount.create` | Create a service account | `true` |
| `serviceAccount.automount` | Automount the service account token | `true` |
| `serviceAccount.annotations` | Service account annotations | `{}` |
| `serviceAccount.name` | Existing service account name | `""` |
| `podAnnotations` | Pod annotations | `{}` |
| `podLabels` | Extra pod labels | `{}` |
| `xray.enabled` | Expose Xray through a Traefik TCP route | `true` |
| `xray.port` | Xray container port | `443` |
| `hostname` | HostSNI used by the Traefik TCP route | `example.com` |
| `env` | Environment variables injected into the container | `{"XRAY_VMESS_AEAD_FORCED":"false","XUI_ENABLE_FAIL2BAN":"true"}` |
| `podSecurityContext` | Pod-level security context | `{}` |
| `securityContext` | Container security context | `{}` |
| `service.type` | Kubernetes Service type | `ClusterIP` |
| `service.port` | HTTP service port | `2053` |
| `ingress.enabled` | Create a standard HTTP Ingress | `false` |
| `ingress.className` | Ingress class name | `""` |
| `ingress.annotations` | Ingress annotations | `{}` |
| `ingress.hosts` | Ingress hosts and paths | `chart-example.local` |
| `ingress.tls` | TLS configuration for the HTTP Ingress | `[]` |
| `livenessProbe` | Liveness probe definition | TCP socket on `http` |
| `readinessProbe` | Readiness probe definition | TCP socket on `http` |
| `resources` | CPU and memory requests/limits | `{}` |
| `autoscaling.enabled` | Enable Horizontal Pod Autoscaler | `false` |
| `autoscaling.minReplicas` | Minimum HPA replicas | `1` |
| `autoscaling.maxReplicas` | Maximum HPA replicas | `100` |
| `autoscaling.targetCPUUtilizationPercentage` | HPA CPU target | `80` |
| `volumes` | Extra pod volumes | `[{name: shared-data, persistentVolumeClaim: {claimName: xui-pvc}}]` |
| `volumeMounts` | Extra container volume mounts | `[{name: shared-data, mountPath: /etc/x-ui/, subPath: x-ui}, {name: shared-data, mountPath: /root/cert/, subPath: cert}]` |
| `nodeSelector` | Node selector | `{}` |
| `tolerations` | Pod tolerations | `[]` |
| `affinity` | Pod affinity rules | `{}` |

## Notes

When `xray.enabled` is `true`, the chart renders a `traefik.io/v1alpha1` `IngressRouteTCP` that routes `HostSNI(hostname)` to `xray.port` with TLS passthrough enabled.
