# kube-prometheus-stack setup for OpenObserve

This guide will help you setup kube-prometheus-stack for OpenObserve which will allow you to send metrics from your kubernetes cluster to OpenObserve.

# Steps

## Create namespace monitoring

```shell
kubectl create namespace monitoring
```

## Create secret OpenObserve credentials

Get the credentials from OpenObserve and create a secret in the monitoring namespace. Replace xxxx with your credentials.

```shell
kubectl create secret generic openobserve-secret --from-literal=username=xxxx --from-literal=password=xxxx -n monitoring
```

## Setup helm repo for kube-prometheus-stack

```shell
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts


helm repo update
```

## Download values file

```shell
wget https://raw.githubusercontent.com/prometheus-community/helm-charts/main/charts/kube-prometheus-stack/values.yaml
```

## Modify the required sections in values file

Change prometheus `agentMode` to `true`

Change grafana `enabled` to `false`

### Add remoteWrite section

Get the remoteWrite url from OpenObserve and add it to the values file. Replace `my_org` with your organization name.

```yaml
remoteWrite:
  - url: https://api.openobserve.ai/api/my_org/prometheus/api/v1/write
    basicAuth:
      username:
        name: openobserve-secret
        key: username
      password:
        name: openobserve-secret
        key: password
```

## Install kube-prometheus-stack

```shell
helm install kps1 prometheus-community/kube-prometheus-stack -f values.yaml -n monitoring
```

## To uninstall kube-prometheus-stack

```shell
helm uninstall kps1 -n monitoring
```
