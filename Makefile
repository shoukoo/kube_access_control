.PHONY: cluster
cluster:
	@echo "\n💻 Creating Kubernetes cluster..."
	kind create cluster --config manifests/cluster.yaml

.PHONY: delete-cluster
delete-cluster:
	@echo "\n💀 Deleting Kubernetes cluster..."
	kind delete cluster
	rm -f ~/.kube/new-config
	rm -f ca.*
	rm -f ca.*
	rm -fr var

.PHONY: create-cluster
create-cluster: cluster get-certificates

.PHONY: get-certificates
get-certificates:
	docker cp kind-control-plane:/etc/kubernetes/pki/ca.key . 
	docker cp kind-control-plane:/etc/kubernetes/pki/ca.crt .
