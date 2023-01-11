#!/bin/bash
set -x

#####################
# Authentication
#####################

# generate a private key for user Bob
openssl genrsa -out bob.key 2048

# generate a certificate signing request
openssl req -new -key bob.key -out bob.csr -subj "/CN=Bob Killen/O=Marketing"

# this will generate a signed certificate
openssl x509 -req -in bob.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out bob.crt -days 10

# generate a new kubeconfig file
touch ~/.kube/new-config 

export KUBECONFIG=~/.kube/new-config

# set cluster config
kubectl config set-cluster dev-cluster --server=https://127.0.0.1:42323 \
--certificate-authority=ca.crt \
--embed-certs=true

# set user config
kubectl config set-credentials bob --client-certificate=bob.crt --client-key=bob.key --embed-certs=true

# set context config
kubectl config set-context dev --cluster=dev-cluster --namespace=marketing --user=bob

#####################
# Authorization
#####################

export KUBECONFIG=~/.kube/config

# create namespace marketing
kubectl create namespace marketing

# apply rbac rules
kubectl apply -f manifests/rbac.yaml

#####################
# Testing
#####################

export KUBECONFIG=~/.kube/new-config
kubectl config use-context dev
kubectl run nginx --image=nginx
kubectl get pods

echo "🤗Yay, it worked"
