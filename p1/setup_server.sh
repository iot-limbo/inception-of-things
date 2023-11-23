#!/bin/bash

# Install k3s
curl -sfL https://get.k3s.io | sh -s - \
    --node-ip 192.168.56.110 \
    --advertise-address 192.168.56.110 \
    --flannel-iface eth1 \
    --write-kubeconfig-mode 644

# Copy server node token to synced folder
cp /var/lib/rancher/k3s/server/node-token /vagrant/server-node-token

# Set alias for kubectl
echo "alias k='kubectl'" >> /home/vagrant/.bashrc
