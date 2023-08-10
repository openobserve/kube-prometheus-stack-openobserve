#!/bin/sh

kubectl apply -f openobserve_secret.yaml
helm -n monitoring -f values.yaml upgrade --install kps1 prometheus-community/kube-prometheus-stack 
