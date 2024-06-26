#!/usr/bin/env bash
# Sets up KVM for virtualization

OSNAME=$(sed -En "s/^NAME=\"(.*)\"/\1/p" </etc/os-release)

if [[ ! $INC_KVM ]]; then
	echo "INC_KVM is not set. Skipping 30-kvm.sh"
	exit 0
fi

echo -e "\n--- Exit if VM accidentally go here ---\n"
if [[ ${IS_VM} == true ]]; then
	echo "This is a VM. Not installing KVM"
	exit 0
fi

if [[ $OSNAME = "Fedora Linux" ]]; then
	echo "Installing KVM packages"
	sudo dnf install -y bridge-utils libvirt virt-install qemu-kvm libvirt-devel virt-top libguestfs-tools guestfs-tools virt-manager
fi

if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
	echo "Installing KVM packages"
	sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils ovmf
fi

echo -e "\n--- Stop and disable dnsmasq ---\n"
sudo systemctl stop dnsmasq
sudo systemctl disable dnsmasq

echo -e "\n--- Creating libvirt group if it doesn't exist ---\n"
sudo getent group | grep libvirt:

if [[ $? -eq 1 ]]; then
	echo "libvirt group does not exist. Creating..."
	sudo groupadd --system libvirt
fi

echo -e "\n--- Adding ${USER} to libvirt group ---\n"
sudo usermod -a -G libvirt "${USER}"

echo -e "\n--- Adding libvirt group to /etc/libvirt/libvirtd.conf ---\n"
sudo sed -i 's/^#unix_sock_group = \"libvirt\"/unix_sock_group = \"libvirt\"/'
sudo sed -i 's/^#unix_sock_rw_perms = \"0770\"/unix_sock_rw_perms = \"0770\"/'

echo -e "\n--- Adding isos and vms Direcotry ---\n"
sudo mkdir -p /var/lib/libvirt/images/isos
sudo mkdir -p /var/lib/libvirt/images/vms

#TODO Custom image directories
