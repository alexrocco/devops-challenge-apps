#!/bin/bash

## Init helm on kubernetes
helm init
kubectl create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default

## NGINX
kubectl apply -f ./nginx/mandatory.yaml
kubectl apply -f ./nginx/patch-configmap-l7.yaml
kubectl apply -f ./nginx/service-l7.yaml

## Grafana + Prometheus - https://github.com/giantswarm/prometheus
kubectl apply -f ./grafana+prometheus/manifests-all.yaml
