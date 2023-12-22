#!/bin/bash

curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
sudo apt install -y gitlab-ce
sudo sed -i 's|external_url \x27http://gitlab.example.com\x27|external_url \x27http://'"$HOST_IP"':9999\x27|g' /etc/gitlab/gitlab.rb 
sudo gitlab-ctl reconfigure
sudo cat /etc/gitlab/initial_root_password
