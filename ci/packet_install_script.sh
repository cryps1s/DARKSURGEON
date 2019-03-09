#!/bin/bash

# Lovingly stolen from Chris Long's DetectionLab Repo (https://github.com/clong/DetectionLab/blob/master/ci/automated_install.sh)

# This script is run on the Packet.net baremetal server for CI tests.
# This script will build the entire lab from scratch and takes 3-4 hours
# on a Packet.net host
# While building, the server will start a webserver on Port 80 that contains
# the text "building". Once the test is completed, the text will be replaced
# with "success" or "failed".

# Install Virtualbox 5.2
echo "deb http://download.virtualbox.org/virtualbox/debian stretch contrib" >> /etc/apt/sources.list
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
apt-get update
apt-get install -y virtualbox-5.2 build-essential unzip git ufw apache2

echo "building" > /var/www/html/index.html

# Set up firewall
ufw allow ssh
ufw allow http
ufw default allow outgoing
ufw --force enable

# Install Packer
mkdir /opt/packer
cd /opt/packer
wget https://releases.hashicorp.com/packer/1.2.3/packer_1.2.3_linux_amd64.zip
unzip packer_1.2.3_linux_amd64.zip
cp packer /usr/local/bin/packer

# Install Vagrant
apt-get install -y vagrant

# Build DARKSURGEON Build Path
mkdir /opt/DARKSURGEON
cd /opt/DARKSURGEON

# Get the Windows ISO File
wget https://darksurgeon.io/files/windows-10-1803-x64-enterprise.iso

# Clone the DARKSURGEON Repository
git clone https://github.com/cryps1s/DARKSURGEON.git

# Get Linux Kernel Headers
apt-get install -y linux-headers-amd64 linux-headers-$(uname -r)

# Kickstart Virtualbox 
/sbin/vboxconfig