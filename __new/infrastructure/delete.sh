#!/bin/bash

BASE_PATH=$PWD

delete_insfrastructure_state() {
  cd state || exit 1
  terraform init
  terraform destroy -auto-approve
  cd $BASE_PATH || exit 1
}

delete_network() {
  cd network || exit 1
  terraform init
  terraform destroy -auto-approve
  cd $BASE_PATH || exit 1
}

delete_kubernetes() {
  cd kubernetes || exit 1
  terraform init
  terraform destroy -auto-approve
  kops delete cluster --yes \
    --name=k8s.alexandrealvarenga.me \
    --state=s3://k8s-devops-challenge-apps-config

    cd $BASE_PATH || exit 1
}

delete_database() {
  cd database || exit 1
  terraform init
  terraform destroy -auto-approve
  cd $BASE_PATH || exit 1
}

delete_database
delete_kubernetes
delete_network
delete_insfrastructure_state
