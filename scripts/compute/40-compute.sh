#!/usr/bin/env bash

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

# Netplan
sudo rm --interactive=never /etc/netplan/*
sudo cp ${FILESDIR}/compute/etc/netplan/01-netcfg.yaml /etc/netplan/01-netcfg.yaml
sudo sed -i 's/VLAN_START/$((${HOSTNAME: -1} + 1))/'
sudo netplan apply
