#!/bin/bash

set -x

kubectl -n marketing apply -f manifests/svc_account.yaml
kubectl -n marketing apply -f manifests/pod.yaml
kubectl -n marketing apply -f manifests/svc_account_rbac.yaml

kubectl exec -n "marketing" "shopping-api" -- tar cf - "var/run/secrets/kubernetes.io/serviceaccount/" | tar xf -

TOKEN=$(cat var/run/secrets/kubernetes.io/serviceaccount/token)
CACERT="var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
NAMESPACE=$(cat var/run/secrets/kubernetes.io/serviceaccount/namespace)

curl --cacert ${CACERT} --header "Authorization: Bearer $TOKEN" -s https://127.0.0.1:42323/api/v1/namespaces/marketing/pods/ 
