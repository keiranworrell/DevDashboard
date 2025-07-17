#!/bin/bash

kubectl create configmap dash-config-volume --from-file=config.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml