#!/bin/sh

helm uninstall kps1 -n monitoring

# create the secret with remote write credentials
kubectl delete -f openobserve_secret.yaml
