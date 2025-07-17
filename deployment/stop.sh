#!/bin/bash

kubectl delete -f deployment.yaml
kubectl delete -f service.yaml
kubectl delete configmap dash-config