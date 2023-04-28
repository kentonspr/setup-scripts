#!/usr/bin/env bash
# Installs and sets up tmux and tools

echo -e "\n### tmux ###\n"

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

if [[ ! $INC_TMUX ]]; then
    echo "INC_TMUX is not set. Skipping 16-tmux.sh"
    exit 0
fi

if [[ OSNAME = "Fedora Linux" ]]; then
    echo "Installing tmux"
    sudo dnf install tmux
fi

if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    echo "Installing tmux"
    sudo apt install -y tmux tmuxp
fi

ln -s ${CODEDIR}/personal/dotfiles/tmux/tmux.conf ${HOME}/.tmux.conf

echo "\n--- installing tmux plugin manager ---\n"
# https://github.com/tmux-plugins/tpm
mkdir -p ${HOME}/.tmux/plugins

git clone https://github.com/tmux-plugins/tpm ${CODEDIR}/public/tpm
ln -s ${CODEDIR}/public/tpm ${HOME}/.tmux/plugins/tpm

echo "\n--- creating tmuxp config dir ---\n"
mkdir -p ${HOME}/.config/tmuxp
