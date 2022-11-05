#!/usr/bin/env bash

: ${ZSHRCDIR:="${ZDOTDIR}/zshrc.d"}
: ${ZPROFILEDIR:="${ZDOTDIR}/zprofile.d"}
: ${CODEDIR:="${HOME}/Code"}

if [[ $SKIP_NODE ]]; then
    echo "SKIP_NODE is set. Skipping 60-node.sh"
    exit 0
fi

REPO="https://github.com/nvm-sh/nvm.git"
REPODIR="${CODEDIR}/public/nvm"

echo "Cloning NVM"
git clone --depth 1 -- ${REPO} ${REPODIR}

echo "Linking ZSH Config"
ln -s ${CODEDIR}/personal/dotfiles/zsh/zshrc.d/70-nvm.zsh ${ZSHRCDIR}/70-nvm.zsh
ln -s ${CODEDIR}/personal/dotfiles/zsh/zprofile.d/70-nvm.zsh ${ZPROFILEDIR}/70-nvm.zsh

source ${ZPROFILEDIR}/70-nvm.sh
source ${ZSHRCDIR}/70-nvm.sh

echo "Installing latest node"
nvm install node

echo "Installing global modules with npm"
npm install -g sass
npm install -g eslint
npm install -g eslint-cli
npm install -g import-js
npm install -g prettier
npm install -g vls
npm install -g vue@latest
npm install -g @vue/cli
vue add @vue/cli-plugin-eslint
