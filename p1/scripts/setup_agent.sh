#!/bin/bash

# Install net-tools
sudo apt-get update
sudo apt-get install -y net-tools

# Install k3s
curl -sfL https://get.k3s.io |  sh -s - \
    agent \
    --server https://192.168.56.110:6443 \
    --node-ip 192.168.56.111 \
    --token-file /vagrant/server-node-token \
    --flannel-iface eth1 \

# delete token file
rm /vagrant/server-node-token