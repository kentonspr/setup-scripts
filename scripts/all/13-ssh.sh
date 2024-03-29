#!/usr/bin/env bash
# Sets up SSH config for server and user

echo -e "\n### ssh ###\n"

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

if [[ ! $INC_SSH ]]; then
    echo "INC_SSH is not set. Skipping 14-ssh.sh"
    exit 0
fi

echo "Install openssh-server"
if [[ OSNAME = "Fedora Linux" ]]; then
    sudo dnf install -y openssh-server
fi

if [[ $OSNAME = "Ubuntu" ]]; then
    sudo apt install -y openssh-server
fi

if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    sudo apt install -y openssh-server
fi

echo "Enabling and starting openssh-server"
sudo systemctl enable sshd
sudo systemctl start sshd

echo "Copying pub key"
cp ${FILESDIR}/ssh/id_rsa.pub ${HOME}/.ssh/

echo "Adding SSH Config"
cp ${FILESDIR}/ssh/config ${HOME}/.ssh/config

echo "Adding id_rsa.pub to authorized keys"
cat ${HOME}/.ssh/id_rsa.pub >> ${HOME}/.ssh/authorized_keys
