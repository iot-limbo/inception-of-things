#!/bin/bash

# disable ufw
sudo ufw disable

# Install k3s
curl -sfL https://get.k3s.io | sh -s - \
    --node-ip 192.168.56.110 \
    --advertise-address 192.168.56.110 \
    --flannel-iface eth1 \
    --write-kubeconfig-mode 644

# Copy server node token to synced folder
sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/server-node-token

# Set alias for kubectl
# TODO: find way not to use sudo
echo "alias k='sudo k3s kubectl'" >> /home/vagrant/.bashrc
