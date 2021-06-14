{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "waldur.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "waldur.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "waldur.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "waldur.labels" -}}
app.kubernetes.io/name: {{ include "waldur.name" . }}
helm.sh/chart: {{ include "waldur.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Set postgres version
*/}}
{{- define "waldur.postgresql.version" -}}
12
{{- end -}}

{{/*
Set postgres host
*/}}
{{- define "waldur.postgresql.host" -}}
{{- if .Values.postgresql.HAEnabed -}}
"postgresql-ha-waldur-pgpool"
{{- else -}}
"postgresql-waldur"
{{- end -}}
{{- end -}}

{{/*
Set postgres port
*/}}
{{- define "waldur.postgresql.port" -}}
"5432"
{{- end -}}

{{/*
Set postgres secret
*/}}
{{- define "waldur.postgresql.secret" -}}
{{- if .Values.postgresql.HAEnabed -}}
"postgresql-ha-waldur-postgresql"
{{- else -}}
"postgresql-waldur"
{{- end -}}
{{- end -}}

{{/*
Set postgres secret password key
*/}}
{{- define "waldur.postgresql.secret.passwordKey" -}}
"postgresql-password"
{{- end -}}

{{/*
Set postgres database name
*/}}
{{- define "waldur.postgresql.dbname" -}}
{{ .Values.postgresql.database | quote }}
{{- end -}}

{{/*
Set postgres user
*/}}
{{- define "waldur.postgresql.user" -}}
{{ .Values.postgresql.username | quote }}
{{- end -}}

{{/*
Set rabbitmq host
*/}}
{{- define "waldur.rabbitmq.host" -}}
{{ printf "%s-rabbitmq-ha" .Values.rabbitmq.hostPrefix }}
{{- end -}}

{{/*
Set rabbitmq URL
*/}}
{{- define "waldur.rabbitmq.rmqUrl" -}}
{{ printf "amqp://%s:%s@%s:%d" .Values.rabbitmq.user .Values.rabbitmq.password .Values.rabbitmq.host (default 5672 .Values.rabbitmq.customAMQPPort) }}
{{- end -}}
