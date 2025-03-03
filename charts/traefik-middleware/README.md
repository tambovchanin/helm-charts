# CrowdSec Bouncer for Traefik

This Helm chart adds middleware configurations for Traefik, including installed plugins that require additional configuration.

## Prerequisites

- Kubernetes 1.16+
- Helm 3.0+
- Traefik installed

## Installation

```bash
# Adding the repository
helm repo add tambovchanin https://tambovchanin.github.io/helm-charts

# Updating the chart list
helm repo update

# Installing with default settings
helm install traefik-middleware tambovchanin/traefik-middleware

# Installing with custom parameters
helm install traefik-middleware tambovchanin/traefik-middleware \
  --set middlewares.test-ipallowlist.ipallowlist.sourceRange="127.0.0.1/32,192.168.1.0/24" \
  --set middlewares.test-ipallowlist.ipallowlist.ipstrategy.excludedIPs="127.0.0.1/32,192.168.1.7"
```

## Configuration

The following table lists the configurable parameters of the chart and their default values.

### Configuration Parameters
| Parameter         | Description                                                   | Default Value |
|------------------|---------------------------------------------------------------|--------------|
| `namespace`      | Namespace in which Traefik is deployed                        | `traefik`    |
| `middlewares`    | Map object containing middleware configurations               | `{}`         |

### Example `values.yaml` File

```yaml
namespace: traefik

middlewares:
  basicAuth:
    prod-auth:
      secret: authsecret
    test-auth:
      users:
        - "test:$apr1$QWgJ9J9w$"
        - "test2:$apr1$QWgJ9J9w$"
      headerField: "Authorization"
      realm: "Restricted"

  ipAllowList:
    dev-allow:
      sourceRange:
        - 127.0.0.1/32
        - 192.168.1.7/32
```

## Using Multiple Middlewares

The chart supports deploying multiple middleware configurations. To do this, add additional items to the `middlewares` section in the `values.yaml` file or specify them during installation via the command line:

```bash
# Installing with custom parameters
helm install traefik-middleware tambovchanin/traefik-middleware \
  --set middlewares.basicAuth.prod-auth.secret=authsecret \
  --set middlewares.basicAuth.test-auth.users="test:$apr1$QWgJ9J9w$,test2:$apr1$QWgJ9J9w$" \
  --set middlewares.basicAuth.test-auth.headerField=Authorization \
  --set middlewares.basicAuth.test-auth.realm=Restricted \
  --set middlewares.ipAllowList.dev-allow.sourceRange="127.0.0.1/32,192.168.1.0/24"
```

## Usage in IngressRoute

After installation, you can use the created middleware in your `IngressRoute`:

```yaml
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: your-app
  namespace: your-namespace
spec:
  entryPoints:
    - web
    - websecure
  routes:
    - match: Host(`your-domain.com`)
      kind: Rule
      services:
        - name: your-service
          port: 80
      middlewares:
        - name: traefik-middleware-default
          namespace: traefik
```

## Updating

```bash
helm repo update
helm upgrade traefik-middleware tambovchanin/traefik-middleware
```

