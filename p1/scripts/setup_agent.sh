#!/bin/bash

# Install k3s
curl -sfL https://get.k3s.io |  sh -s - \
    agent \
    --server https://192.168.56.110:6443 \
    --node-ip 192.168.56.111 \
    --token-file /vagrant/server-node-token \
    --flannel-iface eth1 \

# Install net-tools to use ifconfig
sudo apt install net-tools

# delete token file
rm /vagrant/server-node-token