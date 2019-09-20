#!/bin/bash

unicorn='\360\237\246\204'
redis='\xF0\x9F\x93\x80'
buzz='\xF0\x9F\x90\x9D'
remove='\xE2\x9C\x82'

printf "\n${redis}  Setup Redis Cluster ${redis}\n"

kubectl apply -f ./redis_operator/all-redis-operator-resources.yaml
sleep 10s
kubectl apply -f ./redis_operator/basic.yaml

