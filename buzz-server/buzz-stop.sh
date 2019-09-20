#!/bin/bash

unicorn='\360\237\246\204'
redis='\xF0\x9F\x93\x80'
buzz='\xF0\x9F\x90\x9D'
remove='\xE2\x9C\x82'


printf "${remove} ${buzz}  Remove Buzz Website ${buzz}\n"
kubectl delete -f ./buzz/buzz-webapp-deployment.yaml
kubectl delete -f ./buzz/buzz-webapp-service.yaml

printf "\n${remove} ${buzz}  Remove Buzz RTC Server ${buzz}\n"
kubectl delete -f ./buzz/buzz-rtc-deployment.yaml
kubectl delete -f ./buzz/buzz-rtc-service.yaml

printf "\n${remove} ${buzz}  Remove Buzz SFU Conference Service ${buzz}\n"
kubectl delete -f ./buzz/buzz-conf-deployment.yaml
