# DevOps Challenge - Result

This project creates a infrastructure on AWS to solve this [challenge](README.md)

## Requiriments
- AWS CLI (https://aws.amazon.com/cli/)
- Terraform (https://www.terraform.io/)
- Kubectl (https://kubernetes.io/docs/tasks/tools/)
- Helm (https://helm.sh/)
- Flyway (https://flywaydb.org/)
- kops (https://github.com/kubernetes/kops)
- Docker (https://www.docker.com/)
- Docker Compose (https://docs.docker.com/compose/)

## Steps

### 1. Apps

Deploys the apps, api and web, docker images to DockerHub.

For this execute the following script
```sh
cd apps
./push_images.sh "DockerHub Username" "DockerHub Password"
```
DockerHub links:

https://cloud.docker.com/u/alexxrocco/repository/docker/alexxrocco/devops-challenge-apps-web
https://cloud.docker.com/u/alexxrocco/repository/docker/alexxrocco/devops-challenge-apps-api

### 2. Infrastructure

This step is to create all the required infrastructure on AWS to deply kubernetes cluster and Postgres Server (AWS RDS)

First export AWS credentials to be used on Terraform commands

```sh
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
export AWS_DEFAULT_REGION="region"
```

and then execute the script to create the cluster.

```sh
cd infrastructure
./create.sh
```

After its created, wait for some time to see if Kubernetes API is respoding (10 min is enough)

```sh
kubectl get pods -n kube-system
```
All pods should be ready.

```sh
NAME                                                   READY   STATUS      RESTARTS   AGE
calico-complete-upgrade-v331-9w495                     0/1     Completed   0          3m
calico-kube-controllers-77bb8588fc-w72f6               1/1     Running     0          3m
calico-node-ghv87                                      2/2     Running     0          1m
calico-node-vf595                                      2/2     Running     0          3m
dns-controller-7dcd49f8d6-m4kht                        1/1     Running     0          3m
etcd-server-events-ip-172-20-51-86.ec2.internal        1/1     Running     0          2m
etcd-server-ip-172-20-51-86.ec2.internal               1/1     Running     0          2m
kube-apiserver-ip-172-20-51-86.ec2.internal            1/1     Running     0          2m
kube-controller-manager-ip-172-20-51-86.ec2.internal   1/1     Running     0          2m
kube-dns-6b4f4b544c-bc9qg                              3/3     Running     0          3m
kube-dns-6b4f4b544c-d2lnf                              3/3     Running     0          1m
kube-dns-autoscaler-6b658bd4d5-h8xsc                   1/1     Running     0          3m
kube-proxy-ip-172-20-50-115.ec2.internal               1/1     Running     0          45s
kube-proxy-ip-172-20-51-86.ec2.internal                1/1     Running     0          2m
kube-scheduler-ip-172-20-51-86.ec2.internal            1/1     Running     0          2m
```

To delete the cluster execute the following command:

```sh
./delete.sh
```

### 3. Configuration

On this step the database and kubernetes will be configured.

#### 3.1 Database

To configure Postgres server Flyway will be used create DDL used on the API app. All scripts were versioned on sql folder.

```sh
cd configuration/database
./migrate.sh
```

#### 3.2 Kubernetes

To configure Kubernetes execute the following script

```sh
cd configuration/kubernetes
./kubernetes_config.sh
```

This script will install Helm on cluster and Grafana with Prometheus for monitoring.

To open Grafana execute `proxy_grafana.sh` and open http://localhost:3000/.

### 4. Deploy

This step deploys API and WEB on Kubernetes using Helm Charts.

```sh
cd deploy
./deploy.sh
```

## Improves

Configure centralized logging with Elasticsearch + Fluentd + Kibana.
