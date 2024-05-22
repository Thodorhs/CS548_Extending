#!/bin/bash

# Delete Deployments, Services, and Pods
kubectl delete -f test.yaml
kubectl delete -f webhook.yaml

# Delete Namespaces
kubectl delete namespace custom-label-injector
kubectl delete namespace test

# Delete Docker Image
docker rmi thodorisp/controller-app:v2

# Clean up Docker Containers and Images
docker container prune -f
docker image prune -f

