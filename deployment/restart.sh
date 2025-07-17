#!/bin/bash

kubectl delete -f deployment.yaml
kubectl delete -f service.yaml
kubectl delete configmap dash-config

kubectl create configmap dash-config --from-file=config.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml