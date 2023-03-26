#!/usr/bin/env bash

echo -e "\n### 40-compute.sh ###\n"

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")
VLAN_ID=$((${HOSTNAME: -1} + 1))

echo -e "\n--- netplan ---\n"
# Netplan
sudo rm --interactive=never /etc/netplan/*
sudo cp ${FILESDIR}/compute/etc/netplan/01-netcfg.yaml /etc/netplan/01-netcfg.yaml
sudo sed -i 's/VLAN_START/${VLAN_ID}/' /etc/netplan/01-netcfg.yaml
sudo netplan apply

echo -e "\n--- kvm lvs ---\n"
sudo lvcreate -n isos-lv -L 50G ubuntu-vg
sudo lvcreate -n vms-lv -L 200G ubuntu-vg

sudo mkfs.ext4 /dev/ubuntu-vg/isos-lv
sudo mkfs.ext4 /dev/ubuntu-vg/vms-lv

echo -e '\n# User Added #' | sudo tee -a /etc/fstab
echo '/dev/ubuntu-vg/isos-lv /var/lib/libvirt/images/isos ext4 defaults 0 1' | sudo tee -a /etc/fstab
echo '/dev/ubuntu-vg/vms-lv /var/lib/libvirt/images/vms ext4 defaults 0 1' | sudo tee -a /etc/fstab

