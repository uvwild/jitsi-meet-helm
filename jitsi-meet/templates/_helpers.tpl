{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "jitsi-meet.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "jitsi-meet.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Chart.Name -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Chart.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}


{{/*
Create the istio gateway name
*/}}
{{- define "jitsi-meet.name-gateway" -}}
{{- printf "%s-%s" .Chart.Name "gateway" | trunc 63 -}}
{{- end -}}
{{- define "jitsi-meet.name-gateway-fqdn" -}}
{{- printf "%s/%s-%s" .Values.namespace .Chart.Name  "gateway"  -}}
{{- end -}}

{/*
Create the istio hosts TODO this needs the iteration suffix
*/}}
{{- define "jitsi-meet.name-websvc-fqdn" -}}
{{- printf "%s-%s" .Chart.Name "web.jitsi.svc.cluster.local" | trunc 63 -}}
{{- end -}}

{/*
Create the istio hosts TODO this needs the iteration suffix
*/}}
{{- define "jitsi-meet.name-jvbsvc-fqdn" -}}
{{- printf "%s-%s" .Chart.Name "jvb-0.jitsi.svc.cluster.local" | trunc 63 -}}
{{- end -}}



{{/*
Create the turn server name
*/}}
{{- define "jitsi-meet.name-turn" -}}
{{- printf "%s-%s" .Chart.Name "turn" | trunc 63 -}}
{{- end -}}

{{/*
Create the turn server name
*/}}
{{- define "jitsi-meet.name-turn-config" -}}
{{- printf "%s-%s" .Chart.Name "turn-config" | trunc 63 -}}
{{- end -}}


{{/*
Create the web server name
*/}}
{{- define "jitsi-meet.name-web" -}}
{{- printf "%s-%s" .Chart.Name  "web" | trunc 63 -}}
{{- end -}}

{{/*
Create the web server config name
*/}}
{{- define "jitsi-meet.name-web-config" -}}
{{- printf "%s-%s" .Chart.Name  "web-config" | trunc 63 -}}
{{- end -}}

{{/*
Create the XMPP server name
*/}}
{{- define "jitsi-meet.name-prosody" -}}
{{- printf "%s-%s" .Chart.Name "prosody" | trunc 63 -}}
{{- end -}}

{{/*
Create the XMPP server name
*/}}
{{- define "jitsi-meet.name-prosody-config" -}}
{{- printf "%s-%s" .Chart.Name  "prosody-config" | trunc 63 -}}
{{- end -}}

{{/*
Create the jicofo cmp name
*/}}
{{- define "jitsi-meet.name-jicofo" -}}
{{- printf "%s-%s" .Chart.Name "jicofo" | trunc 63 -}}
{{- end -}}

{{/*
Create the jicofo config name
*/}}
{{- define "jitsi-meet.name-jicofo-config" -}}
{{- printf "%s-%s" .Chart.Name "jicofo-config" | trunc 63 -}}
{{- end -}}

{{/*
Create the jicofo secret name
*/}}
{{- define "jitsi-meet.name-jicofo-secret" -}}
{{- printf "%s-%s" .Chart.Name "jicofo-secret" | trunc 63 -}}
{{- end -}}

{{/*
Create the jvb server name
*/}}
{{- define "jitsi-meet.name-jvb" -}}
{{- printf "%s-%s" .Chart.Name "jvb" | trunc 63 -}}
{{- end -}}

{{/*
Create the jvb config name
*/}}
{{- define "jitsi-meet.name-jvb-config" -}}
{{- printf "%s-%s" .Chart.Name "jvb-config" | trunc 63 -}}
{{- end -}}

{{/*
Create the jvb secret name
*/}}
{{- define "jitsi-meet.name-jvb-secret" -}}
{{- printf "%s-%s" .Chart.Name "jvb-secret" | trunc 63 -}}
{{- end -}}

{{/*
Create the sidecar name for jwt auth
*/}}
{{- define "jitsi-meet.name-jwt-sidecar" -}}
{{- printf "%s-%s" .Chart.Name "jwt" | trunc 63 -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "jitsi-meet.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "jitsi-meet.labels" -}}
app.kubernetes.io/name: {{ include "jitsi-meet.name" . }}
helm.sh/chart: {{ include "jitsi-meet.chart" . }}
app.kubernetes.io/instance: {{ .Chart.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app: {{ .Chart.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "jitsi-meet.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "jitsi-meet.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the link URL namespace/service:port for UDP route tables
*/}}
{{- define "jitsi-meet.udp-route-table-entry" -}}
{{- if .Values.jvb.service.udpPort -}}
{{ printf "%d:%s/%s-jvb:%d" .Values.jvb.udpPort .Chart.Namespace .Chart.Name .Values.jvb.udpPort }}
{{- end -}}
{{- end -}}

{{/*
Create the link URL namespace/service:port for TCP route tables
*/}}
{{- define "jitsi-meet.tcp-route-table-entry" -}}
{{- if .Values.jvb.service.tcpPort -}}
{{ printf "%d:%s/%s-jvb:%d" .Values.jvb.tcpPort .Chart.Namespace .Chart.Name .Values.jvb.tcpPort }}
{{- end -}}
{{- end -}}