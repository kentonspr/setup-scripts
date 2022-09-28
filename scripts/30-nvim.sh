#!/usr/bin/env bash
# Installs neovim and sets it as default editor

if [[ $SKIP_NVIM ]]; then
    echo "SKIP_NVIM is set. Skipping 30-nvim.sh"
    exit 0
fi

if [ "$OSNAME" = "Fedora Linux" ]; then
    sudo dnf install neovim python3-neovim
fi

if [ "$OSNAME" = "Ubuntu" ]; then
    sudo apt install neovim
fi

#TODO Alternatives update
