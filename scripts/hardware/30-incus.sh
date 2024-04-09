#!/usr/bin/env bash
# Sets up Incus for virtualization

OSVERSION=$(sed -En "s/^VERSION_ID=\"(.*)\"/\1/p" </etc/os-release)

if [[ "${INC_INCUS}" != true ]]; then
	echo "INC_INCUS is not set. Skipping 30-lxd.sh"
	exit 0
fi

echo -e "\n--- Exit if VM accidentally go here ---\n"
if [[ "${IS_VM}" = true ]]; then
	echo "This is a VM. Not installing KVM"
	exit 0
fi

echo "Installing Incus packages"
if [[ "${OSVERSION}" = 12 ]]; then
	sudo apt isntall incus/bookwork-backports
fi

sudo apt install incus

if [[ "${IS_INCUS_MASTER}" = true ]]; then
	echo -e "\n--- Initializing Incus ---\n"

	# shellcheck disable=SC2024
	sudo incus init --preseed <"${FILESDIR}/mini/incus/master.preseed.yaml"

	# shellcheck disable=SC2068
	for i in ${INCUS_CHILDREN[@]}; do
		lxc cluster add "${i}" >"${i}.lxd.token"
	done
fi

if [[ "${IS_INCUS_CHILD}" = true ]]; then
	echo -e "\n--- Initializing Incus ---\n"

	cp "${FILESDIR}/mini/incus/child.preseed.yaml" ~/
	sudo sed -i "s/HOSTNAME/${HOSTNAME}/" ~/child.preseed.yml
	sudo sed -i "s/INCUS_JOIN_TOKEN/${INCUS_JOIN_TOKEN}/" ~/child.preseed.yml
	sudo sed -i "s/IP_OCTET/${IP_OCTET}/" ~/child.preseed.yml
	# shellcheck disable=SC2024
	sudo incus init --preseed <~/child.preseed.yml
fi
