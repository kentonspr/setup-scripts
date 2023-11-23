#!/usr/bin/env bash
# Sets up a plex container. Expects /opt/media, /opt/media2,
# and /opt/tank/plex available for volume mounts into the container

echo -e "\n### plex ###\n"

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

echo -e "\n--- create the plex pod ---\n"

sudo podman pod create --name plex \
  -p 10.157.100.1:8080:8080 \

sudo podman run -d \
     --name=plex-svc \
     --pod=plex \
     -e PUID=1000 \
     -e PGID=1000 \
     -e TZ=UTC \
     -e VERSION=docker \
     -e NVIDIA_VISIBLE_DEVICES=all \
     -v /opt/plex:/config \
     -v /opt/media:/opt/media \
     -v /opt/media2:/opt/media2 \
     --restart unless-stopped \
     --hooks-dir=/usr/share/containers/oci/hooks.d/ \
     lscr.io/linuxserver/plex:latest

  # -e PLEX_CLAIM=claim-_rdJnPYtbsYJDziiTAdR \

echo -e "\n--- generate and install systemd files ---\n"

mkdir -p ${HOME}/plex
cd ${HOME}/plex

sudo podman generate systemd --new --files --name plex

for SERVICE in $(find ./ -type f -name '*.service'|sort); do
    FILENAME=$(basename -- "${SERVICE}")
    sudo cp ${SERVICE} /etc/systemd/system/
    sudo systemctl enable ${FILENAME}
done

sudo cp ${FILESDIR}/plex/etc/cron.daily/plex-update /etc/cron.daily/plex-update
sudo chown root:root /etc/cron.daily/plex-update
sudo chmod 755 /etc/cron.daily/plex-update
