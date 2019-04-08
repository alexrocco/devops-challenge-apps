#!/bin/bash

## Init helm on kubernetes
helm init
kubectl create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default

## NGINX
helm install --name nginx stable/nginx-ingress -f helm/nginx/values.yml
