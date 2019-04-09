#!/bin/bash

set -e

echo "######################"
echo "### Migrate script ###"
echo "######################"
echo

BASE_PATH=$(pwd)

cd ../../infrastructure/database || exit 1

echo "Getting database information from terraform..."
POSTGRES_ENDPOINT=$(terraform output endpoint)
POSTGRES_USER=$(terraform output username)
POSTGRES_PASSWORD=$(terraform output password)

cd $BASE_PATH || exit 1

cd ../../infrastructure/kubernetes || exit 1
BASTION_DNS=$(terraform output bastion_elb_dns)

cd $BASE_PATH || exit 1

echo "Openning a connection to k8s bastion to access AWS RDS..."
TUNNER_PORT="8080"
ssh -M -S control-socket -fnNT -L ${TUNNER_PORT}:${POSTGRES_ENDPOINT} -i ~/.ssh/id_rsa admin@${BASTION_DNS}

echo "Check tunnel"
ssh -S control-socket -O check -i ~/.ssh/id_rsa admin@${BASTION_DNS}

echo "Migrating database..."
TUNNEL_POSTGRES_URL="jdbc:postgresql://127.0.0.1:${TUNNER_PORT}/postgres"
flyway migrate -X -locations="filesystem:/$BASE_PATH/sql/" -url=${TUNNEL_POSTGRES_URL} -user=${POSTGRES_USER} -password=${POSTGRES_PASSWORD}

close_ssh() {
  echo "Close tunnel"
  ssh -S control-socket -O exit -i ~/.ssh/id_rsa admin@${BASTION_DNS}
}

trap close_ssh EXIT
