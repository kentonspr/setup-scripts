#!/usr/bin/env bash
# Installs neovim and sets it as default editor

: ${OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")}

if [[ $SKIP_NVIM ]]; then
    echo "SKIP_NVIM is set. Skipping 30-nvim.sh"
    exit 0
fi

if [ "$OSNAME" = "Fedora Linux" ]; then
    sudo dnf install -y neovim python3-neovim
fi

if [ "$OSNAME" = "Ubuntu" ] || [ "$OSNAME" = "Pop!_OS" ]; then
    sudo apt install -y neovim
fi

#TODO Alternatives update
