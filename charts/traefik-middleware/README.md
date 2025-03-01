# CrowdSec Bouncer for Traefik

This Helm chart add Middleware configurations for defined in Traefik middlewares and installed plugins that needed extra configuration.

## Prerequisites

- Kubernetes 1.16+
- Helm 3.0+
- Installed Traefik

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
  --set middlewares.test-ipallowlist.ipallowlist.sourceRange="127.0.0.1/32, 192.168.1.0/24" \
  --set middlewares.test-ipallowlist.ipallowlist.ipstrategy.excludedips="127.0.0.1/32, 192.168.1.7"
```

## Configuration

The following table lists the configurable parameters of the chart and their default values.


#### Configuration parameters
| Parameter                                                | Description                                                                                 | Default Value                               |
|---------------------------------------------------------|------------------------------------------------------------------------------------------|-----------------------------------------------------|
| `namespace`                                             | Name of the namespace                                                                      | `traefik`                                           |
| `middlewares`                                       | Map Object with middlewares where key is the name of the middleware and values are middleware config options                                                                        | `{}`                                           |


#### Exmple of valuees.yaml file

```yaml
namespace: traefik

middlewares: {}
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
        - 192.168.1.7
```

## Using Multiple Middlewares

The chart supports deploying multiple bouncers map different configurations. To do this, add additional items to the `bouncers` array in the `values.yaml` file or during installation via the command line:

```bash
# Installing with custom parameters
helm install traefik-middleware tambovchanin/traefik-middleware \
  --set middlewares.basicAuth.prod-auth.secret=authsecret \
  --set middlewares.basicAuth.test-auth.users="test:$apr1$QWgJ9J9w$,test2:$apr1$QWgJ9J9w$" \
  --set middlewares.basicAuth.test-auth.headerField=Authorization \
  --set middlewares.basicAuth.test-auth.realm=Restricted \
  --set middlewares.ipallowlist.dev-allow.sourceRange="127.0.0.1/32, 192.168.1.0/24"

```

## Usage in IngressRoute

After installation, you can use the created middleware in your IngressRoute:

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
