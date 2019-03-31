#!/bin/bash

cd cluster || exit 1

terraform destroy -auto-approve
kops delete cluster --yes \
  --name=k8s.alexandrealvarenga.me \
  --state=s3://k8s-devops-challenge-apps-config
