#!/bin/bash

#install ubuntu desktop
sudo apt-get install -y --no-install-recommends ubuntu-desktop

#install vscode
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install gnupg2 -y
sudo curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update -y
sudo apt-get install -y code

#install git
sudo apt-get install -y git

#install chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get install -y ./google-chrome-stable_current_amd64.deb
sudo rm ./google-chrome-stable_current_amd64.deb
