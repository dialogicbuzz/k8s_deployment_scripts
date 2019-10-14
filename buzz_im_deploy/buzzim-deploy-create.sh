#!/bin/sh
# Deploy BuzzIM-Deploy to Kubernetes.

# Create a namespace for the tool.
kubectl create -f buzzim-deploy-namespace.yaml

# Create cluster role.
kubectl create -f buzzim-deploy-clusterrole.yaml
kubectl create -f buzzim-deploy-clusterrole-binding.yaml

# Configuration.
kubectl create -f buzzim-deploy-configmap.yaml
kubectl create -f buzzim-deploy-secret.yaml

if [ -f  buzzim-deploy-tls-secret.yaml ]; then
  kubectl -n buzz-deploy create -f buzzim-deploy-tls-secret.yaml
fi

# Deploy the service.
kubectl create -f buzzim-deploy-service.yaml
kubectl create -f buzzim-deploy-deployment.yaml
