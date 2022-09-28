#!/usr/bin/env bash
# Installs and sets up zsh

if [ -n ${SKIP_ZSH} ]; then
    echo "SKIP_ZSH is set. Skipping 16-zsh.sh"
    exit 0
fi

if [ "OSNAME" = "Fedora Linux"];then
    echo "Installing ZSH"
    sudo dnf install zsh
fi

if [ "OSNAME" = "Ubuntu"];then
    echo "Installing ZSH"
    sudo apt install zsh
fi

echo "Changing shell for ${USER}"
chsh -s ${which zsh}

echo "Creating symlinks to zsh configs from dotfiles repo"
mkdir -p ${ZDOTDIR}/zshrc.d
mkdir -p ${ZDOTDIR}/zprofile.d
mkdir -p ${ZDOTDIR}/plugins
mkdir -p ${ZDOTDIR}/functions

ln -s ${CODEDIR}/dotfiles/zsh/zshrc ${$ZDOTDIR}/.zshrc
ln -s ${CODEDIR}/dotfiles/zsh/zprofile ${$ZDOTDIR}/.zprofile

echo "Setup Plugins"
git clone --depth 1 -- https://github.com/trapd00r/LS_COLORS.git ${ZDOTDIR}/plugins/LS_COLORS
git clone --depth 1 -- https://github.com/davidde/git.git ${ZDOTDIR}/plugins/git
git clone --depth 1 -- https://github.com/zsh-git-prompt/zsh-git-prompt.git ${ZDOTDIR}/plugins/zsh-git-prompt
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZDOTDIR}/plugins/zsh-autocomplete
git clone --depth 1 -- https://github.com/zsh-users/zsh-history-substring-search.git ${ZDOTDIR}/plugins/zsh-history-zubstring-search
git clone --depth 1 -- https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZDOTDIR}/plugins/zsh-syntax-highlighting
git clone --depth 1 -- https://github.com/softmoth/zsh-vim-mode.git ${ZDOTDIR}/plugins/zsh-vim-mode
