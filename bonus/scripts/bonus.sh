#!/bin/bash
HOST_IP=$(hostname -I | cut -d " " -f1)

sed -i 's/HOST_IP/'"$HOST_IP"'/g' ../confs/project.yaml

sed -i 's/HOST_IP/'"$HOST_IP"'/g' ../confs/application.yaml

# Apply project and application
sudo kubectl apply -f ../confs/project.yaml -n argocd
sleep 3

sudo kubectl apply -f ../confs/application.yaml -n argocd
sleep 3
