#!/bin/bash

# Set alias for kubectl
# TODO: find way not to use sudo
echo "alias k='sudo k3s kubectl'" >> /home/vagrant/.bashrc

# Install k3s
curl -sfL https://get.k3s.io | sh -