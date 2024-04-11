#!/usr/bin/env bash

echo -e "\n### 40-compute.sh ###\n"

if [[ ! "${INC_IOMMU}" = true ]]; then
	echo "INC_IOMMU is not set. Skipping 29-iommu.sh"
	exit 0
fi

# shellcheck disable=SC2002
CPU_VENDOR=$(cat /proc/cpuinfo | grep vendor_id | head -n1 | sed 's/^vendor_id\t:\s//')

# Set IOMMU if on
if [[ $CPU_VENDOR == 'AuthenticAMD' ]]; then
	sudo sed -i -E 's/^(GRUB_CMDLINE_LINUX_DEFAULT=".*)"$/\1 amdiommu=on kvm.ignore_msrs=1"/' /etc/default/grub
fi

sudo grub-mkconfig -o /boot/grub/grub.cfg
