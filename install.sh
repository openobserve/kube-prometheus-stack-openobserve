#!/bin/sh

# Setup helm

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

kubectl create ns monitoring

# create the secret with remote write credentials
kubectl apply -f openobserve_secret.yaml

helm install kps1 prometheus-community/kube-prometheus-stack -f values_minimal.yaml -n monitoring --create-namespace


# helm -n monitoring -f values_openobserve.yaml upgrade --install kps1 prometheus-community/kube-prometheus-stack 

