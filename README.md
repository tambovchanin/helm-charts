# CrowdSec Bouncer for Traefik

This Helm chart installs CrowdSec Bouncer as middleware for Traefik in a Kubernetes cluster. It allows you to protect your services from malicious traffic using CrowdSec.

## Prerequisites

- Kubernetes 1.16+
- Helm 3.0+
- Installed Traefik
- Installed plugin [Crowdsec Bouncer Traefik plugin](https://plugins.traefik.io/plugins/6335346ca4caa9ddeffda116/crowdsec-bouncer-traefik-plugin)
- Running CrowdSec LAPI server

## Installation

```bash
# Adding the repository
helm repo add tambovchanin https://tambovchanin.github.io/helm-charts

# Updating the chart list
helm repo update

# Installing with default settings
helm install crowdsec-bouncer-traefik tambovchanin/crowdsec-bouncer-traefik

# Installing with custom parameters
helm install crowdsec-bouncer-traefik tambovchanin/crowdsec-bouncer-traefik \
  --set bouncers.crowdsec-bouncer.CrowdsecLapiKey=your-lapi-key \
  --set bouncers.crowdsec-bouncer.CrowdsecLapiHost=your-crowdsec-service:8080
```

## Configuration

The following table lists the configurable parameters of the chart and their default values.


#### Global configuration parameters
| Parameter                                                | Description                                                                                 | Default Value                               |
|---------------------------------------------------------|------------------------------------------------------------------------------------------|-----------------------------------------------------|
| `pluginName`                                            | Name of the Traefik plugin                                                                 | `crowdsec-bouncer-traefik-plugin`                   |
| `namespace`                                             | Name of the namespace                                                                      | `traefik`                                           |
| `bouncers`                                       | Map Object with bouncers where key is the name of the bouncer and values of this key are bouncer options theat are listed below                                                                        | `{}`                                           |

#### Bouncer configuration parameters
| Parameter                                                | Description                                                                                 | Default Value                               |
|---------------------------------------------------------|------------------------------------------------------------------------------------------|-----------------------------------------------------|
| `enabled`                             | Whether the plugin is enabled                                                              | `true`                                             |
| `logLevel`                            | Logging level                                                                              | `INFO`                                              |
| `crowdsecMode`                        | CrowdSec operation mode                                                                    | `live`                                              |
| `crowdsecAppsecEnabled`               | Enable Crowdsec Appsec Server (WAF)                                                        | `false`                                             |
| `crowdsecAppsecHost`                  | Crowdsec Appsec Server host and port                                                       | `"crowdsec:7422"`                                   |
| `crowdsecAppsecPath`                  | Crowdsec Appsec Server path                                                                | `"/"`                                               |
| `crowdsecAppsecFailureBlock`          | Block request when Crowdsec Appsec Server has a status 500                                  | `true`                                              |
| `crowdsecAppsecUnreachableBlock`      | Block request when Crowdsec Appsec Server is unreachable                                   | `true`                                              |
| `crowdsecAppsecBodyLimit`             | Transmit only the first number of bytes to Crowdsec Appsec Server                          | `10485760`                                          |
| `crowdsecLapiScheme`                  | LAPI connection scheme                                                                     | `http`                                              |
| `crowdsecLapiHost`                   | LAPI host and port                                                                         | `"crowdsec-service.crowdsec.svc.cluster.local:8080"`                                   |
| `crowdsecLapiPath`                    | LAPI path                                                                                  | `"/"`                                               |
| `crowdsecLapiKey`                     | LAPI access key                                                                            | `""`                                                |
| `crowdsecLapiTlsInsecureVerify`       | Disable verification of certificate presented by Crowdsec LAPI                              | `false`                                             |
| `crowdsecLapiTlsCertificateAuthority` | PEM-encoded Certificate Authority of the Crowdsec LAPI                                     | `""`                                                |
| `crowdsecLapiTlsCertificateBouncer`   | PEM-encoded client Certificate of the Bouncer                                              | `""`                                                |
| `crowdsecLapiTlsCertificateBouncerKey`| PEM-encoded client private key of the Bouncer                                              | `""`                                                |
| `clientTrustedIPs`                    | List of client IPs to trust, they will bypass any check from the bouncer or cache           | `[]`                                                |
| `remediationHeadersCustomName`        | Name of the header in response when requests are cancelled                                 | `""`                                                |
| `forwardedHeadersCustomName`          | Name of the header where the real IP of the client should be retrieved                     | `"X-Forwarded-For"`                                 |
| `forwardedHeadersTrustedIPs`          | List of IPs of trusted Proxies that are in front of traefik                                | `[]`                                                |
| `redisCacheEnabled`                   | Enable Redis cache instead of in-memory cache                                              | `false`                                             |
| `redisCacheHost`                      | Hostname and port for the Redis service                                                    | `"redis:6379"`                                      |
| `redisCachePassword`                  | Password for the Redis service                                                             | `""`                                                |
| `redisCacheDatabase`                  | Database selection for the Redis service                                                   | `""`                                                |
| `redisUnreachableBlock`               | Block request when Redis is unreachable                                                    | `true`                                              |
| `httpTimeoutSeconds`                  | Default timeout in seconds for contacting Crowdsec LAPI                                    | `10`                                                |
| `updateIntervalSeconds`               | Interval between requests to fetch blacklisted IPs from LAPI (used only in stream mode)     | `60`                                                |
| `updateMaxFailure`                    | Maximum number of times we can not reach Crowdsec before blocking traffic (used in stream and alone mode) | `0`                                                |
| `defaultDecisionSeconds`              | Maximum decision duration (used only in live mode)                                         | `60`                                                |
| `crowdsecCapiMachineId`               | Login for Crowdsec CAPI (used only in alone mode)                                          | `""`                                                |
| `crowdsecCapiPassword`                | Password for Crowdsec CAPI (used only in alone mode)                                       | `""`                                                |
| `crowdsecCapiScenarios`               | Scenarios for Crowdsec CAPI (used only in alone mode)                                      | `[]`                                                |
| `captchaProvider`                     | Provider to validate the captcha                                                           | `""`                                                |
| `captchaSiteKey`                      | Site key for the captcha provider                                                          | `""`                                                |
| `captchaSecretKey`                    | Site secret key for the captcha provider                                                   | `""`                                                |
| `captchaGracePeriodSeconds`           | Period after validation of a captcha before a new validation is required                   | `1800`                                              |
| `captchaHTMLFilePath`                 | Path where the captcha template is stored                                                  | `"/captcha.html"`                                   |
| `banHTMLFilePath`                     | Path where the ban html file is stored                                                     | `""`                                                |

The full list of parameters can be found in the `values.yaml` file. Or by executing the command

```bash
helm show values tambovchanin/crowdsec-bouncer-traefik
```

#### Exmple of valuees.yaml file

```yaml
pluginName: crowdsec-bouncer-traefik-plugin

namespace: traefik

bouncers:
  default:
    enabled: true
    crowdsecLapiScheme: http
    crowdsecLapiHost: crowdsec-service.crowdsec:8080
    crowdsecLapiKey: <api-key-default>
  external-api:
    enabled: true
    crowdsecLapiScheme: http
    crowdsecLapiHost: external.crowdsec.service:443
    crowdsecLapiKey: <api-key-external>
    redisCacheEnabled: true
    redisCacheHost: "redis.crowdsec:6379"
    redisCachePassword: <redis-password>

```

## Using Multiple Bouncers

The chart supports deploying multiple bouncers map different configurations. To do this, add additional items to the `bouncers` array in the `values.yaml` file or during installation via the command line:

```bash
# Installing with custom parameters
helm install crowdsec-bouncer-traefik tambovchanin/crowdsec-bouncer-traefik \
  --set bouncers.public.CrowdsecLapiKey=key1 \
  --set bouncers.internal.CrowdsecLapiKey=key2 \
  --set bouncers.internal.CrowdsecMode=stream
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
        - name: crowdsec-bouncer-traefik-default
          namespace: traefik
```

## Updating

```bash
helm repo update
helm upgrade crowdsec-bouncer-traefik tambovchanin/crowdsec-bouncer-traefik
```
