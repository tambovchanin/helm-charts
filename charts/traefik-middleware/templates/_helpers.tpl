{{/*
Expand the name of the chart.
*/}}
{{- define "traefik-middleware.name" -}}
{{- printf "traefik-%s-%s" .pluginName .name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "traefik-middleware.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | lower | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | lower | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | lower | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "traefik-middleware.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Return the namespace to use for the resources.
*/}}
{{- define "traefik-middleware.namespace" -}}
{{- .Values.namespace }}
{{- end -}}

{{/*
Create a middleware name with a bouncer name
*/}}
{{- define "traefik-middleware.middlewareName" -}}
{{- printf "traefik-%s" . | trunc 63 | lower | trimSuffix "-" }}
{{- end }}
