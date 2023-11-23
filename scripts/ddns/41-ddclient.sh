#!/usr/bin/env bash
# Sets up a ddclient container. Expects configuration file to be in /opt/config

exit 0
echo -e "\n### ddclient ###\n"

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

echo -e "\n--- add ddclient.conf ---\n"
sudo mkdir -p /opt/config
sudo cp ${FILESDIR}/ddns/opt/config/ddclient.conf /opt/config/ddclient.conf

PORKBUN_API_KEY=$(sops -d --extract '["PORKBUN_API_KEY"]' ${FILESDIR}/ddns/vault.sops.yml)
PORKBUN_SECRET_API_KEY=$(sops -d --extract '["PORKBUN_SECRET_API_KEY"]' ${FILESDIR}/ddns/vault.sops.yml)
sed -i -e "s/PORKBUN_API_KEY/${PORKBUN_API_KEY}/" /opt/config/ddclient.conf
sed -i -e "s/PORKBUN_SECRET_API_KEY/${PORKBUN_SECRET_API_KEY}/" /opt/config/ddclient.conf

echo -e "\n--- create the ddclient pod ---\n"

sudo podman pod create --name ddclient

sudo podman run -d \
     --name=ddclient-svc \
     --pod=ddclient \
     -e PUID=1000 \
     -e PGID=1000 \
     -e TZ=UTC \
     -e VERSION=docker \
     -v /opt/config/:/config \
     --restart unless-stopped \
     lscr.io/linuxserver/ddclient:latest

echo -e "\n--- generate and install systemd files ---\n"

mkdir -p ${HOME}/ddclient
cd ${HOME}/ddclient

sudo podman generate systemd --new --files --name ddclient

for SERVICE in $(find ./ -type f -name '*.service'|sort); do
    FILENAME=$(basename -- "${SERVICE}")
    sudo cp ${SERVICE} /etc/systemd/system/
    sudo systemctl enable ${FILENAME}
done

sudo cp ${FILESDIR}/ddns/etc/cron.daily/ddclient-update /etc/cron.daily/ddclient-update
sudo chown root:root /etc/cron.daily/ddclient-update
sudo chmod 755 /etc/cron.daily/ddclient-update
