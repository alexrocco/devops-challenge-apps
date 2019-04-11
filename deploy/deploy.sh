#!/bin/bash

echo "###########################"
echo "### Deploy applications ###"
echo "###########################"
echo

BASE_PATH=$(pwd)
API_CHART="api"
WEB_CHART="web"

deploy_api() {
  cd ../infrastructure/database || exit 1

  echo "Getting database information from terraform..."
  terraform init > /dev/null
  POSTGRES_ENDPOINT=$(terraform output endpoint)

  cd $BASE_PATH || exit 1

  POSTGRES_URL="postgres://app:app@${POSTGRES_ENDPOINT}/app"

  helm install --name ${API_CHART} ./devops-challenge-apps-api --set postgresUrl=${POSTGRES_URL}
}

deploy_web() {
  API_SERVICE_NAME="http://${API_CHART}-devops-challenge-apps-api"

  helm install --name ${WEB_CHART} ./devops-challenge-apps-web --set apiHost=${API_SERVICE_NAME}
}

deploy_api
deploy_web
