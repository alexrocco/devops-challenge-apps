#!/bin/bash

## Init helm on kubernetes
helm init
kubectl create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default

## NGINX
cd nginx || exit 1
kubectl apply -f ./mandatory.yaml ./patch-configmap-l7.yaml ./service-l7.yaml
