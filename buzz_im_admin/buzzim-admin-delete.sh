#!/bin/sh
# Remove BuzzIM Admin from Kubernetes.

# Cleanup the database
kubectl create -f buzzim-admin-delete-db-job.yaml
kubectl -n buzzim-admin wait --for=condition=complete --timeout=30s job/buzzim-admin-delete-db

# Delete the namespace for the tool, this will cleanup everything else.
kubectl delete -f buzzim-admin-namespace.yaml

