#!/bin/bash

# Install k3s
curl -sfL https://get.k3s.io |  sh -s - \
    agent \
    --server https://192.168.56.110:6443 \
    --node-ip 192.168.56.111 \
    --token-file /vagrant/server-node-token \
    --flannel-iface eth1 \