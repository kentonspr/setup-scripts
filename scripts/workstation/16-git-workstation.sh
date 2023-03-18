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

echo "Copying git configuration"
cp ${FILESDIR}/git/gitconfig ${HOME}/.gitconfig
cp ${FILESDIR}/git/gitconfig-dscrn ${HOME}/.gitconfig-dscrn

echo "Setting up Code directories"
[[ ! -d ${CODEDIR}/personal ]] && mkdir -p ${CODEDIR}/personal
[[ ! -d ${CODEDIR}/public ]] && mkdir -p ${CODEDIR}/public

echo "Downloading all personal github repos"
cd ${CODEDIR}/personal
GITHUB_TOKEN=$(sops -d --extract '["github_token"]' ${FILESDIR}/all/vault.sops.yml)
GITHUB_JSON=$(curl -H "Authorization: token ${GITHUB_TOKEN}" https://api.github.com/search/repositories\?q\=user:kentonspr)

for item in $(jq -c -r '.items[].ssh_url' <<< $GITHUB_JSON); do
    git clone $item
done
