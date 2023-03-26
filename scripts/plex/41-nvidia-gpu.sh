#!/usr/bin/env bash

# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#id9

echo -e "\n### 41-nvidia-gpu.sh ###\n"

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")
DRIVER_VERSION=495

echo -e "\n--- isntall driver ---\n"
sudo apt install nvidia-driver-${DRIVER_VERSION} libnvidia-encode-${DRIVER_VERSION} -y
sudo apt-mark hold nvidia-driver-${DRIVER_VERSION} libnvidia-encode-${DRIVER_VERSION}

echo -e "\n--- nvidia-container-toolkit ---\n"
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
    && curl -s -L https://nvidia.github.io/libnvidia-container/gpgkey \
	| sudo apt-key add - \
    && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list \
	| sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

sudo apt-get update \
    && sudo apt-get install -y nvidia-container-toolkit

echo -e "\n--- copy oci ---\n"
sudo cp ${FILESDIR}/plex/usr/share/containers/oci/hooks.d/oci-nvidia-hook.json \
/usr/share/containers/oci/hooks.d/oci-nvidia-hook.json

cat  /usr/share/containers/oci/hooks.d/oci-nvidia-hook.json
