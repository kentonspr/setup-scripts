#!/usr/bin/env bash

echo -e "\n### 20-netplan.sh ###\n"

OSNAME=$(sed -En "s/^NAME=\"(.*)\"/\1/p" </etc/os-release)

if [[ ! ${OSNAME} = "Debian GNU/Linux" ]]; then
  echo -e "OS is not Debian GNU/Linux. Skipping 20-netplan.sh"
  exit 0
fi

# install netplan
sudo apt install -y netplan.io

# enable services
sudo systemctl unmask systemd-networkd.service
sudo systemctl unmask systemd-resolved.service
sudo systemctl enable systemd-networkd.service
sudo systemctl mask networking
sudo systemctl enable systemd-resolved.service

# install systemd-resolved
sudo apt install -y systemd-resolved

# migrate current config to netplan
sudo ENABLE_TEST_COMMANDS=1 netplan migrate

# change permissions
sudo chmod 600 /etc/netplan/*

sudo netplan apply

# remove old packages
sudo apt purge ifupdown resolvconf -y && sudo rm -rf /etc/network

# symlnk /etc/resolv.conf to /run/systemd/resolve/stub-resolv.conf
sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
