{{/*
Expand the name of the chart.
*/}}
{{- define "origin-public-ip.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
--------------------------------------------------------------------------------
*/}}

{{/*
App name
*/}}
{{- define "origin-public-ip.name" -}}
{{ include "origin-public-ip.name" . }}-app
{{- end }}
