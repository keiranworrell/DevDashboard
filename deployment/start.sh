#!/bin/bash

kubectl create configmap dash-config --from-file=config.yaml
kubectl create secret generic gh-token-secret --from-literal=password=${GH_TOKEN}
kubectl apply -f backDeployment.yaml
kubectl apply -f frontDeployment.yaml
kubectl apply -f service.yaml