# Kubernetes Cluster

This project creates a Kubernetes cluster into AWS using Terraform as an infrastucture as a code.

## Requiriments
- AWS CLI (https://aws.amazon.com/cli/)
- Terraform (https://www.terraform.io/)
- Kubectl (https://kubernetes.io/docs/tasks/tools/)

## Instalation

To create the cluster first export AWS credentials

```sh
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
export AWS_DEFAULT_REGION="region"
```

and then execute the script to create the cluster.

```sh
./create_cluster.sh
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
./delete_cluster.sh
```
