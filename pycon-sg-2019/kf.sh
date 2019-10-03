#!/bin/bash

# via https://mickey.dev/posts/getting-started-with-openfaas/

k3d create
sleep 10
export KUBECONFIG="$(k3d get-kubeconfig --name='k3s-default')"
git clone https://github.com/openfaas/faas-netes.git
cd ./faas-netes
kubectl apply -f namespaces.yml
sleep 25

# Generate a random 40 character password
export PASSWORD="password"

# Add password as a Kubernetes secret in the openfaas namespace
kubectl -n openfaas create secret generic basic-auth \
--from-literal=basic-auth-user=admin \
--from-literal=basic-auth-password="$PASSWORD"
sleep 25

kubectl apply -f ./yaml
sleep 25

# brew install faas-cli

kubectl port-forward svc/gateway -n openfaas 31112:8080 &
export OPENFAAS_URL=http://127.0.0.1:31112
echo $PASSWORD | faas-cli login --password-stdin

sleep 5
