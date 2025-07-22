#!/bin/bash

kubectl delete -f frontDeployment.yaml
kubectl delete -f backDeployment.yaml
kubectl delete -f service.yaml
kubectl delete -f ingress.yaml
kubectl delete configmap dash-config