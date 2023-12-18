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

sleep 5

# Create k3d cluster
# -p : 포트 매핑을 지정하는 옵션
# LoadBalancer : 여러 서버 또는 서비스에 대한 트래픽을 분산시키는 역할을 하는 네트워크 장비
# Kubernetes 클러스터를 생성할 때 이 옵션을 사용하는 것은 외부에서 클러스터 내의 서비스에 접근하기 위한 것
# LoadBalancer가 호스트의 특정 포트로 트래픽을 받으면 이를 클러스터 내부의 서비스로 전달
# 즉, -p 옵션과 LoadBalancer를 사용하는 것은 외부에서 클러스터의 서비스에 접근할 수 있도록 포트 매핑 및 로드 밸런서를 설정하는 과정
# 8080:80@loadbalancer : 호스트의 8080 포트를 클러스터 내부의 로드 밸런서가 노출한 80 포트로 매핑
# 8888:30888@loadbalancer : 호스트의 8888 포트를 클러스터 내부의 로드 밸런서가 노출한 30888 포트로 매핑
sudo k3d cluster create -p 8080:80@loadbalancer -p 8888:30888@loadbalancer
sleep 5
sudo kubectl create namespace dev
sudo kubectl create namespace argocd
sleep 3
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sleep 3
sudo kubectl wait --for=condition=Ready pods --all -n argocd
sleep 3
sudo kubectl apply -f ../confs/ingress.yaml -n argocd
sleep 3
sudo kubectl apply -f ../confs/project.yaml -n dev
sleep 3
sudo kubectl apply -f ../confs/application.yaml -n argocd
sleep 5
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# sudo kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
# sudo kubectl port-forward svc/argocd-server -n argocd 8080:443

# sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d