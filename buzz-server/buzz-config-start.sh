#!/bin/bash

unicorn='\360\237\246\204'
redis='\xF0\x9F\x93\x80'
buzz='\xF0\x9F\x90\x9D'
remove='\xE2\x9C\x82'

printf "\n${buzz}  Setup Buzz Config Map ${buzz}\n"
kubectl create configmap buzz-config --from-env-file=./buzz/buzz.properties