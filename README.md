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
  --set bouncers[0].CrowdsecLapiKey=your-lapi-key \
  --set bouncers[0].CrowdsecLapiHost=your-crowdsec-service:8080
```

## Configuration

The following table lists the configurable parameters of the chart and their default values.

| Parameter                                                | Description                                                                                 | Default Value                               |
|---------------------------------------------------------|------------------------------------------------------------------------------------------|-----------------------------------------------------|
| `pluginName`                                            | Name of the Traefik plugin                                                                 | `crowdsec-bouncer-traefik-plugin`                   |
| `namespace`                                             | Name of the namespace                                                                      | `traefik`                                           |
| `bouncers[].name`                                       | Name of the bouncer                                                                        | `default`                                           |
| `bouncers[].enabled`                             | Whether the plugin is enabled                                                              | `false`                                             |
| `bouncers[].logLevel`                            | Logging level                                                                              | `INFO`                                              |
| `bouncers[].crowdsecMode`                        | CrowdSec operation mode                                                                    | `live`                                              |
| `bouncers[].crowdsecAppsecEnabled`               | Enable Crowdsec Appsec Server (WAF)                                                        | `false`                                             |
| `bouncers[].crowdsecAppsecHost`                  | Crowdsec Appsec Server host and port                                                       | `"crowdsec:7422"`                                   |
| `bouncers[].crowdsecAppsecPath`                  | Crowdsec Appsec Server path                                                                | `"/"`                                               |
| `bouncers[].crowdsecAppsecFailureBlock`          | Block request when Crowdsec Appsec Server has a status 500                                  | `true`                                              |
| `bouncers[].crowdsecAppsecUnreachableBlock`      | Block request when Crowdsec Appsec Server is unreachable                                   | `true`                                              |
| `bouncers[].crowdsecAppsecBodyLimit`             | Transmit only the first number of bytes to Crowdsec Appsec Server                          | `10485760`                                          |
| `bouncers[].crowdsecLapiScheme`                  | LAPI connection scheme                                                                     | `http`                                              |
| `bouncers[].crowdsecLapiHost`                   | LAPI host and port                                                                         | `"crowdsec:8080"`                                   |
| `bouncers[].crowdsecLapiPath`                    | LAPI path                                                                                  | `"/"`                                               |
| `bouncers[].crowdsecLapiKey`                     | LAPI access key                                                                            | `""`                                                |
| `bouncers[].crowdsecLapiTlsInsecureVerify`       | Disable verification of certificate presented by Crowdsec LAPI                              | `false`                                             |
| `bouncers[].crowdsecLapiTlsCertificateAuthority` | PEM-encoded Certificate Authority of the Crowdsec LAPI                                     | `""`                                                |
| `bouncers[].crowdsecLapiTlsCertificateBouncer`   | PEM-encoded client Certificate of the Bouncer                                              | `""`                                                |
| `bouncers[].crowdsecLapiTlsCertificateBouncerKey`| PEM-encoded client private key of the Bouncer                                              | `""`                                                |
| `bouncers[].clientTrustedIPs`                    | List of client IPs to trust, they will bypass any check from the bouncer or cache           | `[]`                                                |
| `bouncers[].remediationHeadersCustomName`        | Name of the header in response when requests are cancelled                                 | `""`                                                |
| `bouncers[].forwardedHeadersCustomName`          | Name of the header where the real IP of the client should be retrieved                     | `"X-Forwarded-For"`                                 |
| `bouncers[].forwardedHeadersTrustedIPs`          | List of IPs of trusted Proxies that are in front of traefik                                | `[]`                                                |
| `bouncers[].redisCacheEnabled`                   | Enable Redis cache instead of in-memory cache                                              | `false`                                             |
| `bouncers[].redisCacheHost`                      | Hostname and port for the Redis service                                                    | `"redis:6379"`                                      |
| `bouncers[].redisCachePassword`                  | Password for the Redis service                                                             | `""`                                                |
| `bouncers[].redisCacheDatabase`                  | Database selection for the Redis service                                                   | `""`                                                |
| `bouncers[].redisUnreachableBlock`               | Block request when Redis is unreachable                                                    | `true`                                              |
| `bouncers[].httpTimeoutSeconds`                  | Default timeout in seconds for contacting Crowdsec LAPI                                    | `10`                                                |
| `bouncers[].updateIntervalSeconds`               | Interval between requests to fetch blacklisted IPs from LAPI (used only in stream mode)     | `60`                                                |
| `bouncers[].updateMaxFailure`                    | Maximum number of times we can not reach Crowdsec before blocking traffic (used in stream and alone mode) | `0`                                                |
| `bouncers[].defaultDecisionSeconds`              | Maximum decision duration (used only in live mode)                                         | `60`                                                |
| `bouncers[].crowdsecCapiMachineId`               | Login for Crowdsec CAPI (used only in alone mode)                                          | `""`                                                |
| `bouncers[].crowdsecCapiPassword`                | Password for Crowdsec CAPI (used only in alone mode)                                       | `""`                                                |
| `bouncers[].crowdsecCapiScenarios`               | Scenarios for Crowdsec CAPI (used only in alone mode)                                      | `[]`                                                |
| `bouncers[].captchaProvider`                     | Provider to validate the captcha                                                           | `""`                                                |
| `bouncers[].captchaSiteKey`                      | Site key for the captcha provider                                                          | `""`                                                |
| `bouncers[].captchaSecretKey`                    | Site secret key for the captcha provider                                                   | `""`                                                |
| `bouncers[].captchaGracePeriodSeconds`           | Period after validation of a captcha before a new validation is required                   | `1800`                                              |
| `bouncers[].captchaHTMLFilePath`                 | Path where the captcha template is stored                                                  | `"/captcha.html"`                                   |
| `bouncers[].banHTMLFilePath`                     | Path where the ban html file is stored                                                     | `""`                                                |

The full list of parameters can be found in the `values.yaml` file.

## Using Multiple Bouncers

The chart supports deploying multiple bouncers with different configurations. To do this, add additional items to the `bouncers` array in the `values.yaml` file or during installation via the command line:

```bash
helm install crowdsec-bouncer-traefik tambovchanin/crowdsec-bouncer-traefik \
  --set bouncers[0].name=public \
  --set bouncers[0].CrowdsecLapiKey=key1 \
  --set bouncers[1].name=internal \
  --set bouncers[1].CrowdsecLapiKey=key2 \
  --set bouncers[1].CrowdsecMode=stream
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
