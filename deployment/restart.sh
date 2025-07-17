#!/bin/bash

kubectl delete -f deployment.yaml
kubectl delete -f service.yaml
kubectl delete configmap dash-config-volume

kubectl create configmap dash-config-volume --from-file=config.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml