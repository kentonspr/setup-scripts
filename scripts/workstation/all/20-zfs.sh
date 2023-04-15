#!/usr/bin/env bash

echo -e "\n### zfs ###\n"

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

if [[ ! $INC_ZFS ]]; then
    echo "INC_ZFS is not set. Skipping 30-zfs.sh"
    exit 0
fi

echo -e "\n--- Install ZFS ---\n"
if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    sudo apt install -y zfsutils-linux nfs-kernel-server
fi
