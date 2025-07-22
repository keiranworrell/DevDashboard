#!/bin/bash

kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

kubectl delete -f frontDeployment.yaml
kubectl delete -f backDeployment.yaml
kubectl delete -f service.yaml
kubectl delete -f ingress.yaml
kubectl delete configmap dash-config