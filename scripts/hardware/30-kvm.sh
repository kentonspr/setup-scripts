#!/usr/bin/env bash
# Sets up KVM for virtualization

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")
CPU_VENDOR=$(cat /proc/cpuinfo | grep vendor_id | head -n1 | sed 's/^vendor_id\t:\s//')

if [[ ! $INC_KVM ]]; then
    echo "INC_KVM is not set. Skipping 30-kvm.sh"
    exit 0
fi

if [[ $OSNAME = "Fedora Linux" ]]; then
    echo "Installing KVM packages"
    sudo dnf install -y bridge-utils libvirt virt-install qemu-kvm libvirt-devel virt-top libguestfs-tools guestfs-tools virt-manager
fi

    if [[  $OSNAME = "Ubuntu" ]] || [[  $OSNAME = "Pop!_OS" ]]; then
    echo "Installing KVM packages"
    sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils ovmf
fi

echo "Stop and disable dnsmasq"
sudo systemctl stop dnsmasq
sudo systemctl disable dnsmasq

echo "Creating libvirt group if it doesn't exist"
sudo getent group | grep libvirt:

if [[  $? -eq 1 ]]; then
    echo "libvirt group does not exist. Creating..."
    sudo groupadd --system libvirt
fi

echo "Adding ${USER} to libvirt group"
sudo usermod -a -G libvirt ${USER}

echo "Adding libvirt group to /etc/libvirt/libvirtd.conf"
sudo sed -i 's/^#unix_sock_group = \"libvirt\"/unix_sock_group = \"libvirt\"/'
sudo sed -i 's/^#unix_sock_rw_perms = \"0770\"/unix_sock_rw_perms = \"0770\"/'

# Set IOMMU if on
if [[ ! -z $IOMMU ]]; then
   if [[ $CPU_VENDOR == 'AuthenticAMD' ]]; then
       sudo sed -i -E 's/^(.*)"$/\1 amdiommu=on kvm.ignore_msrs=1"/' /etc/default/grub
   fi
fi

#TODO Custom image directories
