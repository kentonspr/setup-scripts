#!/usr/bin/env bash
# Installs neovim and sets it as default editor

echo -e "\n### glances ###\n"

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

if [[ ! $INC_GLANCES ]]; then
    echo "INC_GLANCES is not set. Skipping 30-glances.sh"
    exit 0
fi

echo -e "\n--- Installing Glances ---\n"
if [[ $OSNAME = "Fedora Linux" ]]; then
    sudo dnf install -y glances
fi

if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    sudo apt install -y glances
fi
