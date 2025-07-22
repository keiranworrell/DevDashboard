#!/bin/bash

kubectl delete -f frontDeployment.yaml
kubectl delete -f backDeployment.yaml
kubectl delete -f service.yaml
kubectl delete -f ingress.yaml
kubectl delete configmap dash-config

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

kubectl create configmap dash-config --from-file=config.yaml
kubectl apply -f backDeployment.yaml
kubectl apply -f frontDeployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml