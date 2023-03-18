#!/usr/bin/env bash
# Installs and configures git

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

if [[ ! $INC_GIT ]]; then
    echo "INC_GIT is not set. Skipping 15-git.sh"
    exit 0
fi

if [[ $OSNAME = "Fedora Linux" ]]; then
    echo "Ensuring git dependencies are installed"
    sudo dnf install git
fi

if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    echo "Ensuring git dependencies are installed"
    sudo apt install git
fi

echo "Setting up git private key"
[[ ! -d ${HOME}/.ssh ]] && mkdir ${HOME}/.ssh
sops -d --extract '["github_rsa_priv_key"]' ${FILESDIR}/ssh/vault.sops.yml > ${HOME}/.ssh/github
chmod 600 ${HOME}/.ssh/github

echo "Copying pub key"
cp ${FILESDIR}/ssh/github.pub ${HOME}/.ssh/

echo "Adding github key to agent"
chmod +x ${FILESDIR}/ssh/ssh-add-sops.sh
ssh-add ${HOME}/.ssh/github

echo "Setting up Code directory"
[[ ! -d ${CODEDIR}/personal ]] && mkdir -p ${CODEDIR}/personal

echo "Clone dotfiles"
cd ${CODEDIR}/personal

git clone git@github.com:kentonspr/dotfiles.git
