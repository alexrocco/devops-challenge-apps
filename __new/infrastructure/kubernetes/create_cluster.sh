#!/bin/bash

BASE_PATH=$PWD

cd state || exit 1

terraform init
terraform apply -auto-approve

cd $BASE_PATH

cd cluster || exit 1

kops create cluster \
--name=k8s.alexandrealvarenga.me \
--state=s3://k8s-devops-challenge-apps-config \
--dns-zone=alexandrealvarenga.me \
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
