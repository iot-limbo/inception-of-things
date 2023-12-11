#!/bin/bash

sudo apt update -y
sudo apt upgrade -y

## Install curl
sudo apt install curl -y

# Install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Install k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Create k3d cluster
sudo k3d cluster create -p 8080:80@loadbalancer -p 8888:30888@loadbalancer
sudo kubectl create namespace dev
sudo kubectl create namespace argocd
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sudo kubectl wait --for=condition=Ready pods --all -n argocd
sudo kubectl apply -f ../confs/ingress.yaml -n dev
sudo kubectl apply -f ../confs/playground.yaml -n dev
sudo kubectl apply -f ../confs/application.yaml -n argocd
sudo kubectl wait --for=condition=Ready pods --all -n argocd
