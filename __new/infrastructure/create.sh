#!/bin/bash

BASE_PATH=$PWD
VPC_ID=""
NETWORK_CIDR=""

create_infrastructure_state() {
  cd state || exit 1

  terraform init
  terraform apply -auto-approve

  cd $BASE_PATH || exit 1
}

create_network() {
  cd network || exit 1

  terraform init
  terraform apply -auto-approve

  VPC_ID=$(terraform output vpc_id)
  NETWORK_CIDR=$(terraform output vpc_cidr_block)

  cd $BASE_PATH || exit 1
}

create_kubernetes() {
  cd kubernetes || exit 1

  export VPC_ID
  export NETWORK_CIDR

  NAME="k8s.alexandrealvarenga.me"
  export KOPS_STATE_STORE="s3://k8s-devops-challenge-apps-config"

  kops create cluster \
  --name=${NAME} \
  --dns-zone=alexandrealvarenga.me \
  --vpc=${VPC_ID} \
  --zones=us-east-1e \
  --node-count 1 \
  --master-size t2.medium \
  --node-size t2.medium \
  --networking calico \
  --topology private \
  --bastion="true" \
  --out=. \
  --target=terraform

  terraform init
  terraform apply -auto-approve

   kops export kubecfg ${NAME}
}

create_infrastructure_state
create_network
create_kubernetes
