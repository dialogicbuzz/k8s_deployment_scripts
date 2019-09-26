#!/bin/bash

#Generate a self-signed certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout buzz-self-signed.key -out buzz-self-signed.crt -subj "/C=US/ST=New Jersey/L=Parsippany/O=Dialogic, Inc./OU=AFA/CN=buzz.dialogic.com"

#Create a Secret for the certificate
kubectl -n ingress-nginx create secret tls default-ssl-certificate --key  buzz-self-signed.key --cert buzz-self-signed.crt

#Deploy
kubectl apply -f mandatory.yaml
kubectl apply -f service-nodeport.yaml
