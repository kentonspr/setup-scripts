#!/usr/bin/env bash

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

echo -e "\n--- Install Packages ---\n"
if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    sudo apt install -y nfs-common
fi

sudo mkdir /opt/sabnzbd_config
# mkdir /opt/scratch

echo -e "\n--- create the sabnzbd pod ---\n"

sudo podman pod create --name sabnzbd \
  -p 10.157.200.1:8080:8080 \

sudo podman run -d \
     --name=sabnzbd-svc \
     --pod=sabnzbd \
     -e PUID=1000 \
     -e PGID=1000 \
     -e TZ=UTC \
     -e VERSION=docker \
     -v /opt/sabnzbd_config:/config \
     -v /opt/scratch:/downloads \
     --restart unless-stopped \
     lscr.io/linuxserver/sabnzbd:latest

echo -e "\n--- generate and install systemd files ---\n"

mkdir -p ${HOME}/sabnzbd
cd ${HOME}/sabnzbd

sudo podman generate systemd --new --files --name sabnzbd

for SERVICE in $(find ./ -type f -name '*.service'|sort); do
    FILENAME=$(basename -- "${SERVICE}")
    sudo cp ${SERVICE} /etc/systemd/system/
    sudo systemctl enable ${FILENAME}
done

sudo cp ${FILESDIR}/jollyroger/etc/cron.daily/sabnzbd-update /etc/cron.daily/sabnzbd-update
sudo chown root:root /etc/cron.daily/sabnzbd-update
sudo chmod 755 /etc/cron.daily/sabnzbd-update
