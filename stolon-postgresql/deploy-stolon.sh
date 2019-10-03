#!/bin/sh
# Deploy Stolon on Kubernetes
#
# The image must be available from the Docker registry specified by the image name.
#

# The deployment may be customised by defining the below vars before invoking this script
#
: "${STOLON_IMAGE:=sorintlab/stolon:master-pg10}"
: "${STOLON_NAMESPACE:=stolon}"
: "${YAML_DIR:=.}"

if [ ${STOLON_NAMESPACE} != "default" ]; then
  kubectl create namespace ${STOLON_NAMESPACE}
fi

sed -i "s/namespace:.*$/namespace: ${STOLON_NAMESPACE}/g" "${YAML_DIR}"/role.yaml
kubectl apply -f "${YAML_DIR}"/role.yaml

sed -i "s/namespace:.*$/namespace: ${STOLON_NAMESPACE}/g" "${YAML_DIR}"/role-binding.yaml
kubectl apply -f "${YAML_DIR}"/role-binding.yaml

kubectl -n ${STOLON_NAMESPACE} run -i -t stolonctl --image=${STOLON_IMAGE} --restart=Never --rm -- /usr/local/bin/stolonctl --cluster-name=kube-stolon --store-backend=kubernetes --kube-resource-kind=configmap init -y
kubectl -n ${STOLON_NAMESPACE} create -f "${YAML_DIR}"/secret.yaml
kubectl -n ${STOLON_NAMESPACE} create -f "${YAML_DIR}"/stolon-sentinel.yaml
kubectl -n ${STOLON_NAMESPACE} create -f "${YAML_DIR}"/stolon-keeper.yaml
kubectl -n ${STOLON_NAMESPACE} create -f "${YAML_DIR}"/stolon-proxy.yaml
kubectl -n ${STOLON_NAMESPACE} create -f "${YAML_DIR}"/stolon-proxy-service.yaml
