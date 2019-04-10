#!/bin/bash

echo "#########################"
echo "### Proxy Grafana ... ###"
echo "#########################"
echo

GRAFANA_POD_NAME=$(kubectl get pods --namespace monitoring -l "app=grafana,component=core" -o jsonpath="{.items[0].metadata.name}")

kubectl port-forward --namespace monitoring ${GRAFANA_POD_NAME} 3000:3000
