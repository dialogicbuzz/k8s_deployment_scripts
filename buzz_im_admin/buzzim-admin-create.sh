#!/bin/sh
# Deploy BuzzIM Admin to Kubernetes.

# Create a namespace for the tool.
kubectl create -f buzzim-admin-namespace.yaml

# Configuration.
kubectl create -f buzzim-admin-configmap.yaml
kubectl create -f buzzim-admin-secret.yaml

if [ -f  buzzim-admin-tls-secret.yaml ]; then
  kubectl -n buzzim-admin create -f buzzim-admin-tls-secret.yaml
fi

# Create & initialise the database
kubectl create -f buzzim-admin-init-db-job.yaml
kubectl -n buzzim-admin wait --for=condition=complete --timeout=30s job/buzzim-admin-init-db

# Deploy the service.
kubectl create -f buzzim-admin-service.yaml
kubectl create -f buzzim-admin-statefulset.yaml


