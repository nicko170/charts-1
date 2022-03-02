{{/*
Expand the name of the chart.
*/}}
{{- define "soketi.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "soketi.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "soketi.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "soketi.labels" -}}
helm.sh/chart: {{ include "soketi.chart" . }}
{{ include "soketi.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "soketi.bullExporterLabels" -}}
helm.sh/chart: {{ include "soketi.chart" . }}
{{ include "soketi.bullExporterSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app: bull-exporter
{{- end }}

{{/*
Selector labels
*/}}
{{- define "soketi.selectorLabels" -}}
app.kubernetes.io/name: {{ include "soketi.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: soketi
{{- end }}

{{- define "soketi.bullExporterSelectorLabels" -}}
app.kubernetes.io/name: {{ include "soketi.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: bullmq-exporter
{{- end }}

app: bullmq-exporter

{{/*
Create the name of the service account to use
*/}}
{{- define "soketi.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "soketi.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
