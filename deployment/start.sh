#!/bin/bash

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml


kubectl create configmap dash-config --from-file=config.yaml
kubectl create secret generic gh-token-secret --from-literal=password=${GH_TOKEN}
kubectl apply -f backDeployment.yaml
kubectl apply -f frontDeployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml