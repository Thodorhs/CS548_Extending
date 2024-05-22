#!/bin/bash

# Delete the deployment
kubectl delete deployment greeting-controller

# Delete services created by the controller
kubectl delete service hello-world
kubectl delete service hello-to-all

# Delete the CRD
kubectl delete crd greetings.hy548.csd.uoc.gr

# Delete ClusterRole and ClusterRoleBinding
kubectl delete clusterrole greeting-controller-role
kubectl delete clusterrolebinding greeting-controller-binding

# Delete the ServiceAccount
kubectl delete serviceaccount greeting-controller

# Verify deletion
echo "Checking remaining deployments..."
kubectl get deployments

echo "Checking remaining services..."
kubectl get services

echo "Checking remaining CRDs..."
kubectl get crds

echo "Checking remaining pods..."
kubectl get pods

