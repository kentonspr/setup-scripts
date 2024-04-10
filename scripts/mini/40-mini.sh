#!/usr/bin/env bash

echo -e "\n### 40-mini.sh ###\n"

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

# isntall netplan.io
echo -e "\n--- netplan ---\n"
sudo rm --interactive=never /etc/netplan/*
sudo cp "${FILESDIR}/mini/etc/netplan/01-netcfg.yaml" /etc/netplan/01-netcfg.yaml
sudo sed -i "s/IP_OCTET/${IP_OCTET}/" /etc/netplan/01-netcfg.yaml
sudo sed -i "s/MAC_OCTET/${MAC_OCTET}/" /etc/netplan/01-netcfg.yaml
sudo chmod 600 /etc/netplan/01-netcfg.yaml

sudo netplan apply
