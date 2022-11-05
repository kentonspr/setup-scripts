#!/usr/bin/env bash
# Sets up SSH config for server and user

: ${OSNAME:=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")}
: ${FILESDIR:="${PWD}/files"}

if [[ $SKIP_SSH ]; then
    echo "SKIP_SSH is set. Skipping 14-ssh.sh"
    exit 0
fi

echo "Install openssh-server"
if [[ "OSNAME" = "Fedora Linux" ]]; then
    sudo dnf install -y openssh-server
fi

if [[ "$OSNAME" = "Ubuntu" ]] || [[ "$OSNAME" = "Pop!_OS" ]]; then
    sudo apt install -y openssh-server
fi

echo "Enabling and starting openssh-server"
sudo systemctl enable openssh-server
sudo systemctl start openssh-server

echo "Adding SSH private key"
[[ ! -d ${HOME}/.ssh ]] && mkdir ${HOME}/.ssh
sops -d --extract '["id_rsa_priv_key"]' ${FILESDIR}/all/vault.sops.yml > ${HOME}/.ssh/id_rsa
chmod 600 ${HOME}/.ssh/id_rsa

echo "Copying pub key"
cp ${FILESDIR}/ssh/id_rsa.pub ${HOME}/.ssh/

echo "Adding SSH Config"
cp ${FILESDIR}/ssh/config ${HOME}/.ssh/config

echo "Adding id_rsa.pub to authorized keys"
cat ${HOME}/.ssh/id_rsa.pub >> ${HOME}/.ssh/authorized_keys
