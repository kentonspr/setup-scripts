#!/usr/bin/env bash

echo -e "\n### 40-plex.sh ###\n"

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

echo -e "\n--- Install Packages ---\n"
if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    sudo apt install -y nfs-common
fi

echo -e "\n--- Add mounts ---\n"

sudo mkdir /opt/media
sudo mkdir /opt/media2
# sudo mkdir /opt/scratch
sudo mkdir /opt/plex

echo '# User Added #' | sudo tee -a /etc/fstab
echo 'media-share:/opt/media /opt/media nfs defaults 0 0' | sudo tee -a /etc/fstab
echo 'media-share:/opt/media2 /opt/media2 nfs defaults 0 0' | sudo tee -a /etc/fstab
# echo 'scratch-share:/opt/scratch /opt/scratch nfs defaults 0 0' | sudo tee -a /etc/fstab
echo 'server-share:/opt/tank/plex /opt/plex nfs defaults 0 0' | sudo tee -a /etc/fstab
