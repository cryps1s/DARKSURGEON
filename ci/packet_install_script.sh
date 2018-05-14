#!/bin/bash

# Lovingly stolen from Chris Long's DetectionLab Repo (https://github.com/clong/DetectionLab/blob/master/ci/automated_install.sh)

# This script is run on the Packet.net baremetal server for CI tests.
# This script will build the entire lab from scratch and takes 3-4 hours
# on a Packet.net host
# While building, the server will start a webserver on Port 80 that contains
# the text "building". Once the test is completed, the text will be replaced
# with "success" or "failed".

# Install Virtualbox 5.1
echo "deb http://download.virtualbox.org/virtualbox/debian xenial contrib" >> /etc/apt/sources.list
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
apt-get update
apt-get install -y virtualbox-5.1 build-essential unzip git ufw apache2

echo "building" > /var/www/html/index.html

# Set up firewall
ufw allow ssh
ufw allow http
ufw default allow outgoing
ufw --force enable

# Install Packer
mkdir /opt/packer
cd /opt/packer
wget https://releases.hashicorp.com/packer/1.1.3/packer_1.1.3_linux_amd64.zip
unzip packer_1.1.3_linux_amd64.zip
cp packer /usr/local/bin/packer

mkdir /opt/DARKSURGEON
cd /opt/DARKSURGEON
wget https://www.dropbox.com/s/k47i8v7vmej26ed/windows-10-1803-x64-enterprise.iso