#!/bin/bash

echo "#############################"
echo "### Undeploy applications ###"
echo "#############################"
echo

API_CHART="api"
WEB_CHART="web"

helm delete --purge $API_CHART
helm delete --purge $WEB_CHART
