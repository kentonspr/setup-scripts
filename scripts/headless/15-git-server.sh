#!/usr/bin/env bash
# Installs and configures git

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")
DOTFILES_REPO="https://github.com/kentonspr/dotfiles.git"

if [[ ! $INC_GIT ]]; then
    echo "INC_GIT is not set. Skipping 15-git.sh"
    exit 0
fi

if [[ $OSNAME = "Fedora Linux" ]]; then
    echo "Ensuring git is installed"
    sudo dnf install git
fi

if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    echo "Ensuring git is installed"
    sudo apt install -y git
fi

echo "Setting up Code directorie"
mkdir -p ${CODEDIR}/personal

echo "Downloading dotfiles github repo"
cd ${CODEDIR}/personal

git clone ${DOTFILES_REPO}
