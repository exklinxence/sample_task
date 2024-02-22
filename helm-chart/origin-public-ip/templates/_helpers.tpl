{{/*
Expand the name of the chart.
*/}}
{{- define "origin-public-ip.name" -}}
{{- default .Chart.Name | trimSuffix "-" }}
{{- end }}

{{/*
--------------------------------------------------------------------------------
*/}}

{{/*
App name
*/}}
{{- define "origin-public-ip.app.name" -}}
{{ include "origin-public-ip.name" . }}-app-1
{{- end }}
