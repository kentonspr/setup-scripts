#!/usr/bin/env bash
# Sets up LXD for virtualization

if [[ ! $INC_LXD ]]; then
	echo "INC_LXD is not set. Skipping 30-lxd.sh"
	exit 0
fi

echo -e "\n--- Exit if VM accidentally go here ---\n"
if [[ ${IS_VM} == true ]]; then
	echo "This is a VM. Not installing KVM"
	exit 0
fi

if ! command -v snap; then
	echo "Installing LXD packages"
	sudo snap install lxd --chanel=latest/stable
fi

# TODO: Setup LXD from preseed file and write token to DB for future use
if [[ "${IS_LXD_MASTER}" ]]; then
	echo -e "\n--- Initializing LXD ---\n"
	sudo lxd init
fi
