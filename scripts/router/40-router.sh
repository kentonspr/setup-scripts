#!/usr/bin/env bash

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

# dhcp-helper pre-install
sudo cp ${FILESDIR}/router/etc/default/dhcp-helper /etc/default/dhcp-helper

# Install packages
sudo DEBIAN_FRONTEND=noninteractive apt-get install dhcp-helper vlan net-tools

# dhcp-helper pre-install
sudo systemctl enable dhcp-helper.service

# Netplan
sudo rm --interactive=never /etc/netplan/*
sudo cp ${FILESDIR}/router/etc/netplan/01-netcfg.yaml /etc/netplan/01-netcfg.yaml
sudo chmod 600 /etc/netplay/01-netcfg.yaml
sudo netplan apply

# iptables
sudo mkdir /etc/iptables
sudo cp ${FILESDIR}/router/etc/iptables/iptables.rules /etc/iptables/iptables.rules
sudo cp ${FILESDIR}/router/etc/systemd/system/iptables-rules.service /etc/systemd/system/iptables-rules.service
sudo systemctl enable iptables-rules.service

# Enable IP routing
sudo cp ${FILESDIR}/router/etc/sysctl.d/50-router.conf /etc/sysctl.d/50-router.conf
