#!/bin/bash

echo "###########################"
echo "### Deploy applications ###"
echo "###########################"
echo

BASE_PATH=$(pwd)

cd ../infrastructure/database || exit 1

echo "Getting database information from terraform..."
POSTGRES_ENDPOINT=$(terraform output endpoint)

cd $BASE_PATH || exit 1

POSTGRES_URL="postgres://app:app@${POSTGRES_ENDPOINT}/app"

helm install --name api ./devops-challenge-apps-api --set postgresUrl=${POSTGRES_URL}
