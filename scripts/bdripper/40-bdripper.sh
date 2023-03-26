#!/usr/bin/env bash

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")


echo -e "\n--- Install Packages ---\n"
if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    sudo apt install -y nfs-common
fi

echo -e "\n--- Add mounts ---\n"

sudo mkdir /opt/scratch

echo '# User Added #' | sudo tee -a /etc/fstab
echo 'scratch-share:/opt/scratch /opt/scratch nfs defaults 0 0' | sudo tee -a /etc/fstab
