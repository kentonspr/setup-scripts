#!/usr/bin/env bash
# Sets up KVM for virtualization

: ${OSNAME:=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")}

if [[ $SKIP_KVM ]]; then
    echo "SKIP_KVM is set. Skipping 30-kvm.sh"
    exit 0
fi

if [[  "$OSNAME" = "Fedora Linux" ]]; then
    echo "Installing KVM packages"
    sudo dnf install -y bridge-utils libvirt virt-install qemu-kvm libvirt-devel virt-top libguestfs-tools guestfs-tools virt-manager
fi

    if [[  "$OSNAME" = "Ubuntu" ]] || [[  "$OSNAME" = "Pop!_OS" ]]; then
    echo "Installing KVM packages"
    sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
fi

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

#TODO Custom image directories
