#!/usr/bin/env bash

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

# # Install packages
# sudo apt install dhcp-helper vlan

# # Netplan
# sudo rm --interactive=never /etc/netplan/*
# sudo cp ${FILESDIR}/router/01-netcfg.yaml /etc/netplan/01-netcfg.yaml
# sudo netplan apply

# # iptables
# sudo mkdir /etc/iptables
# sudo cp ${FILESDIR}/router/iptables.rules /etc/iptables/iptables.rules
# sudo cp ${FILESDIR}/router/iptables-rules.service /etc/systemd/system/iptables-rules.service
# sudo systemctl enable iptables-rules.service

# # dhcp-helper
# sudo cp ${FILESDIR}/router/dhcp-helper /etc/default/dhcp-helper

# # Enable IP routing
# sudo -w sysctl net.ipv4.ip_forward=1
