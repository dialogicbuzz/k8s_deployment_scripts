#!/bin/bash

#Create a Secret for the certificate
kubectl -n ingress-nginx create secret tls default-ssl-certificate --key  buzz-self-signed.key --cert buzz-self-signed.crt

#Deploy
kubectl apply -f mandatory.yaml
kubectl apply -f service-nodeport.yaml
