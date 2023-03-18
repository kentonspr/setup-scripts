#!/usr/bin/env bash
# Sets up SSH config for server and user

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

if [[ ! $INC_SSH ]]; then
    echo "INC_SSH is not set. Skipping 14-ssh.sh"
    exit 0
fi

echo "Install openssh-server"
if [[ OSNAME = "Fedora Linux" ]]; then
    sudo dnf install -y openssh-server
fi

if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    sudo apt install -y ssh-askpass
fi

echo "Adding SSH private key"
[[ ! -d ${HOME}/.ssh ]] && mkdir ${HOME}/.ssh
sops -d --extract '["id_rsa_priv_key"]' ${FILESDIR}/ssh/vault.sops.yml > ${HOME}/.ssh/id_rsa
chmod 600 ${HOME}/.ssh/id_rsa
