#!/bin/bash

# Install net-tools
sudo apt-get update
sudo apt-get install -y net-tools

# Install k3s
curl -sfL https://get.k3s.io | sh -s - \
    --node-ip 192.168.56.110 \
    --advertise-address 192.168.56.110 \
    --flannel-iface eth1 \
    --write-kubeconfig-mode 644

kubectl apply -f /vagrant/confs

# Set alias for kubectl
echo "alias k='kubectl'" >> /home/vagrant/.bashrc

