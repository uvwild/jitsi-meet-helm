# Jitsi Meet
A [Jitsi Meet](https://jitsi.org/jitsi-meet/) Chart for Kubernetes

## Install chart
To download and to install the Jitsi Meet Chart, make sure that you have the Helm CLI (v3+) installed and clone this repository on your machine.

To install the chart, in your terminal, go to the `jitsi-meet-helm` repository and run the following command:

```bash
helm install --namespace jitsi -n jitsi-meet jitsi-meet -f ./otc/values.yaml --wait
```

It assumes that you have a [Nginx Ingress](https://docs.nginx.com/nginx-ingress-controller/overview/) controller and you use [CertManager](https://cert-manager.io/docs/installation/kubernetes/) along with [ACME](https://cert-manager.io/docs/configuration/acme/) issuer type for managing the HTTPS certificates.

Because `--wait` flag, the status will be given once Jisti Meet is ready.

## Updating the chart
To update the chart, in your terminal, go to the `jitsi-meet-helm` repository and run the following command:

```bash
helm upgrade jitsi-meet jitsi-meet -f ./jitsi-meet-examples/basic/values.yaml --namespace $MY_NAMESPACE --wait
```

`$MY_NAMESPACE` should be replaced by the namespace you want to use for Jitsi Meet.

## Delete the chart
To delete the chart, in your terminal, go to the `jitsi-meet-helm` repository and run the following command:

```bash
helm delete --purge jitsi-meet
```

## Demo
Currently, the `otc` example is running on [`jitsid.otcd.gardener.t-systems.net`](https://jitsid.otcd.gardener.t-systems.net). Feel free to give it a try and share your feedback !

## Approach

* This chart is ongoing work - it runs currently one replica of each component
*  currently istio is used for routing ingress TCP ports 
* JVB service uses a `NodePort` type for routing UDP outside of the cluster

## Configuration

The following table lists the configurable parameters of the Jitsi Meet chart and their default values.

| Parameter                                               | Description                            | Default         |
|---------------------------------------------------------|----------------------------------------|-----------------|
| `image.pullSecrets`                                     | Image pull secrets                     | `nil`           |
| `jicofo.image.repository`                               | Image repository                       | `jitsi/jicofo`  |
| `jicofo.image.tag`                                      | Image tag                              | `latest`        |
| `jicofo.environment`                                    | Additional environment variables       | `[]`            |
| `jicofo.componentSecret`                                | Base64 encoded component secret        | `nil`           |
| `jicofo.userAuth.enabled`                               | Enabled authentication                 | `false`         |
| `jicofo.userAuth.name`                                  | Username for authentication            | `focus`         |
| `jicofo.userAuth.secret`                                | Secret for authentication              | `nil`           |
| `jicofo.resources`                                      | Pod resources                          | `{}`            |
| `jvb.image.repository`                                  | Image repository                       | `jitsi/jvb`     |
| `jvb.image.tag`                                         | Image tag                              | `latest`        |
| `jvb.replicaCount`                                      | Replica count                          | `1`             |
| `jvb.environment`                                       | Additional environment variables       | `[]`            |
| `jvb.securityContext.fsGroup`                           | Security context deployment            | `412`           |
| `jvb.service.annotations`                               | Service annotations                    | `[]`            |
| `jvb.service.type`                                      | Service type                           | `NodePort`      |
| `jvb.service.externalTrafficPolicy`                     | External traffic policy                | `Cluster`       |
| `jvb.ingress.enabled`                                   | Yet to come, ingress UDP/TCP           | `false`         |
| `jvb.resources`                                         | Pod resources                          | `{}`            |
| `jvb.nodeSelector`                                      | Node selector                          | `{}`            |
| `jvb.affinity`                                          | Node affinity                          | `{}`            |
| `jvb.tolerations`                                       | Node tolerations                       | `{}`            |
| `jvb.userAuth.enabled`                                  | Enabled authentication                 | `false`         |
| `jvb.userAuth.name`                                     | Username for authentication            | `focus`         |
| `jvb.userAuth.secret`                                   | Secret for authentication              | `nil`           |
| `prosody.image.repository`                              | Image repository                       | `jitsi/prosody` |
| `prosody.image.tag`                                     | Image tag                              | `latest`        |
| `prosody.environment`                                   | Additional environment variables       | `[]`            |
| `prosody.replicaCount`                                  | Replica count                          | `1`             |
| `prosody.service.annotations`                           | Service annotations                    | `[]`            |
| `prosody.service.type`                                  | Service type                           | `ClusterIP`     |
| `prosody.service.sessionAffinityConfig.clientIPConfig`  | Timeout client IP                      | `10800`         |
| `prosody.hpa.enabled`                                   | Yet to come, horizontal pod autoscaler | `false`         |
| `prosody.resources`                                     | Pod resources                          | `{}`            |
| `prosody.nodeSelector`                                  | Node selector                          | `{}`            |
| `prosody.affinity`                                      | Node affinity                          | `{}`            |
| `web.tolerations`                                       | Node tolerations                       | `{}`            |
| `web.image.repository`                                  | Image repository                       | `jitsi/prosody` |
| `web.image.tag`                                         | Image tag                              | `latest`        |
| `web.environment`                                       | Additional environment variables       | `[]`            |
| `web.replicaCount`                                      | Replica count                          | `1`             |
| `web.service.annotations`                               | Service annotations                    | `[]`            |
| `web.service.type`                                      | Service type                           | `ClusterIP`     |
| `web.service.port`                                      | Service port                           | `80`            |
| `web.resources`                                         | Pod resources                          | `{}`            |
| `web.nodeSelector`                                      | Node selector                          | `{}`            |
| `web.affinity`                                          | Node affinity                          | `{}`            |
| `web.tolerations`                                       | Node tolerations                       | `{}`            |
| `web.ingress.enabled`                                   | Ingress controller                     | `false`         |
| `web.ingress.annotations`                               | Ingress annotations                    | `[]`            |
| `web.ingress.hosts`                                     | Ingress host configuration             | `[]`            |
| `web.ingress.tls`                                       | TLS for ingress controller             | `[]`            |
| `ingressControllerNamespace`                            | Yet to come, namespace ingress         | `nil`           |
| `serviceAccount.create`                                 | Create service account                 | `true`          |
| `serviceAccount.name`                                   | Service account name                   | `nil`           |
| `podSecurityContext`                                    | Pod Security context (except JVB)      | `{}`            |
| `securityContext`                                       | Security context                       | `{}`            |

## Help
For any assistance needed, please open an issue.

## Contributing
In case you notice an issue or want to implement some improvements, feel free to open an issue describing your finding and/or to open a pull-request.

