#!/bin/bash

kubectl delete -f deployment.yaml
kubectl delete -f service.yaml

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml