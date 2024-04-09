#!/usr/bin/env bash
# Sets up LXD for virtualization

if [[ "${INC_LXD}" != true ]]; then
	echo "INC_LXD is not set. Skipping 30-lxd.sh"
	exit 0
fi

echo -e "\n--- Exit if VM accidentally go here ---\n"
if [[ "${IS_VM}" = true ]]; then
	echo "This is a VM. Not installing KVM"
	exit 0
fi

if ! command -v snap; then
	echo "Installing LXD packages"
	sudo snap install lxd --chanel=latest/stable
fi

if [[ "${IS_LXD_MASTER}" = true ]]; then
	echo -e "\n--- Initializing LXD ---\n"

	# shellcheck disable=SC2024
	sudo lxd init --preseed <"${FILESDIR}/mini/lxd/master.preseed.yaml"

	# shellcheck disable=SC2068
	for i in ${LXD_CHILDREN[@]}; do
		lxc cluster add "${i}" >"${i}.lxd.token"
	done
fi

if [[ "${IS_LXD_MASTER}" = false ]]; then
	echo -e "\n--- Initializing LXD ---\n"

	cp "${FILESDIR}/mini/lxd/child.preseed.yaml" ~/
	sudo sed -i "s/HOSTNAME/${HOSTNAME}/" ~/child.preseed.yml
	sudo sed -i "s/LXD_JOIN_TOKEN/${LXD_JOIN_TOKEN}/" ~/child.preseed.yml
	sudo sed -i "s/IP_OCTET/${IP_OCTET}/" ~/child.preseed.yml
	# shellcheck disable=SC2024
	sudo lxd init --preseed <~/child.preseed.yml
fi
