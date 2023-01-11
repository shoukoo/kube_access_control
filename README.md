# How authentication and authorization works in Kubernetes

Follow this [tutorial](https://blog.kubesimplify.com/kubernetes-access-control-with-authentication-authorization-admission-control) to understand how authorization and authentication works in Kubernetes

## Create a cluster
```
make create-cluster
```

## Create a user and rbac roles
```
./gen-user.sh
```

## Create a service account and rbac roles
```
./gen-svc-account.sh
```

## Delete cluster
```
make delete-cluster
```
