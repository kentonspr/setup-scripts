#!/usr/bin/env bash
# Installs and sets up zsh

echo -e "\n### zsh ###\n"

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")
OSVERSION=$(cat /etc/os-release | sed -En "s/^VERSION_ID=\"(.*)\"/\1/p")

if [[ ! $INC_ZSH ]]; then
    echo "INC_ZSH is not set. Skipping 16-zsh.sh"
    exit 0
fi

if [[ OSNAME = "Fedora Linux" ]]; then
    echo "Installing ZSH"
    sudo dnf install zsh
fi

if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    echo "Installing ZSH"
    sudo apt install -y zsh
fi

echo -e "\n--- Changing shell for ${USER} ---\n"
chsh -s $(which zsh)

echo "Creating symlinks to zsh configs from dotfiles repo"
mkdir -p ${ZDOTDIR}/zshrc.d
mkdir -p ${ZDOTDIR}/zprofile.d
mkdir -p ${ZDOTDIR}/plugins
mkdir -p ${ZDOTDIR}/functions

ln -s ${CODEDIR}/personal/dotfiles/zsh/zshenv ${HOME}/.zshenv

ln -s ${CODEDIR}/personal/dotfiles/zsh/zprofile ${ZDOTDIR}/.zprofile
ln -s ${CODEDIR}/personal/dotfiles/zsh/zshrc ${ZDOTDIR}/.zshrc

# zprofile.d configs
ln -s ${CODEDIR}/personal/dotfiles/zsh/zprofile.d/10-local-bin.zsh ${ZDOTDIR}/zprofile.d/10-local-bin.zsh

# zshrc.d configs
ln -s ${CODEDIR}/personal/dotfiles/zsh/zshrc.d/01-config.zsh ${ZDOTDIR}/zshrc.d/01-config.zsh
ln -s ${CODEDIR}/personal/dotfiles/zsh/zshrc.d/10-aliases.zsh ${ZDOTDIR}/zshrc.d/10-aliases.zsh


if [[ $OSNAME = "Pop!_OS" ]] && [[ $OSVERSION = "22.04" ]]; then
    echo "source ${HOME}/.zshenv" >> ${HOME}/.xprofile
    echo 'source ${ZDOTDIR}/.zprofile' >> ${HOME}/.xprofile
fi

echo -e "\n--- Setup Plugins ---\n"
git clone --depth 1 -- https://github.com/trapd00r/LS_COLORS.git ${ZDOTDIR}/plugins/LS_COLORS
git clone --depth 1 -- https://github.com/davidde/git.git ${ZDOTDIR}/plugins/git
git clone --depth 1 -- https://github.com/zsh-git-prompt/zsh-git-prompt.git ${ZDOTDIR}/plugins/zsh-git-prompt
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZDOTDIR}/plugins/zsh-autocomplete
git clone --depth 1 -- https://github.com/zsh-users/zsh-history-substring-search.git ${ZDOTDIR}/plugins/zsh-history-substring-search
git clone --depth 1 -- https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZDOTDIR}/plugins/zsh-syntax-highlighting
git clone --depth 1 -- https://github.com/jeffreytse/zsh-vi-mode.git ${ZDOTDIR}/plugins/zsh-vi-mode
