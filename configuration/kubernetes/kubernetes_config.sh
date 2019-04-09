#!/bin/bash

## Init helm on kubernetes
helm init
kubectl create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default

echo "Wait until tiller pod is ready"
sleep 60

## NGINX
helm install --name nginx stable/nginx-ingress -f helm/nginx/values.yml
