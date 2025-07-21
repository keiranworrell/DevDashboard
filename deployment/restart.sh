#!/bin/bash

kubectl delete -f frontDeployment.yaml
kubectl delete -f backDeployment.yaml
kubectl delete -f service.yaml
kubectl delete configmap dash-config

kubectl create configmap dash-config --from-file=config.yaml
kubectl apply -f backDeployment.yaml
kubectl apply -f frontDeployment.yaml
kubectl apply -f service.yaml