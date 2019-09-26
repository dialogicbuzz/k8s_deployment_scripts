#!/bin/sh
# Deploy Stolon on Kubernetes
#
# The image must be available from the Docker registry specified by the image name.
#



YAML_DIR="."

kubectl apply -f "${YAML_DIR}"/role.yaml
kubectl apply -f "${YAML_DIR}"/role-binding.yaml
kubectl run -i -t stolonctl --image=dialogicbuzz/stolon --restart=Never --rm -- /usr/local/bin/stolonctl --cluster-name=kube-stolon --store-backend=kubernetes --kube-resource-kind=configmap init
kubectl create -f "${YAML_DIR}"/secret.yaml
kubectl create -f "${YAML_DIR}"/stolon-sentinel.yaml
kubectl create -f "${YAML_DIR}"/stolon-keeper.yaml
kubectl create -f "${YAML_DIR}"/stolon-proxy.yaml
kubectl create -f "${YAML_DIR}"/stolon-proxy-service.yaml
