#! /bin/bash
# kind delete cluster --name openfaas
trash faas-netes
k3d delete cluster --name openfaas
k3d delete cluster --name k3s-default 
