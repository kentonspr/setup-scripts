#!/usr/bin/env bash

exit 0
echo -e "\n### intel gpu ###\n"

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

echo -e "\n--- copy i915.conf to /etc/modprobe.d/ ---\n"
sudo cp ${FILESDIR}/media-vm/etc/modprobe.d/* /etc/modprobe.d/
