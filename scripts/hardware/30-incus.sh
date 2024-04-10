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
	echo "deb http://deb.debian.org/debian bookworm-backports main" | sudo tee /etc/apt/sources.list.d/bookworm-backports.list
	sudo apt update
	sudo apt install incus/bookworm-backports
fi

# add cluster master
if [[ "${IS_INCUS_MASTER}" = true ]]; then
	echo -e "\n--- Initializing Incus ---\n"

	# shellcheck disable=SC2024
	sudo incus admin init --preseed <"${FILESDIR}/mini/incus/master.preseed.yaml"

	# shellcheck disable=SC2068
	for i in ${INCUS_CHILDREN[@]}; do
		incus cluster add "${i}" >"${i}.incus.token"
	done
fi

# add cluster children
if [[ "${IS_INCUS_CHILD}" = true ]]; then
	echo -e "\n--- Initializing Incus ---\n"

	cp "${FILESDIR}/mini/incus/child.preseed.yaml" ~/
	sudo sed -i "s/HOSTNAME/${HOSTNAME}/" ~/child.preseed.yml
	sudo sed -i "s/INCUS_JOIN_TOKEN/${INCUS_JOIN_TOKEN}/" ~/child.preseed.yml
	sudo sed -i "s/IP_OCTET/${IP_OCTET}/" ~/child.preseed.yml
	# shellcheck disable=SC2024
	sudo incus admin init --preseed <~/child.preseed.yml
fi

# TODO: Setup a non cluster incus install

# add user to incus group
getent group incus-admin >/dev/null 2>&1
# shellcheck disable=SC2181
if [ ! $? -eq 0 ]; then
	echo "Incus group does not exist. Creating..."
	sudo groupadd --system incus-admin
fi

sudo usermod -a -G incus-admin "${USER}"

# Set IOMMU if on
if [[ "${IOMMU}" = true ]]; then
	if [[ $CPU_VENDOR == 'AuthenticAMD' ]]; then
		sudo sed -i -E 's/^(GRUB_CMDLINE_LINUX_DEFAULT=".*)"$/\1 amdiommu=on kvm.ignore_msrs=1"/' /etc/default/grub
	fi

	sudo grub-mkconfig -o /boot/grub/grub.cfg
fi
