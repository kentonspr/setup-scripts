#!/usr/bin/env bash

if [[ ! $INC_NODE ]]; then
    echo "INC_NODE is not set. Skipping 60-node.sh"
    exit 0
fi

REPO="https://github.com/nvm-sh/nvm.git"
REPODIR="${CODEDIR}/public/nvm"

echo "Cloning NVM"
git clone --depth 1 -- ${REPO} ${REPODIR}

echo "Linking ZSH Config"
ln -s ${CODEDIR}/personal/dotfiles/zsh/zshrc.d/70-nvm.zsh ${ZSHRCDIR}/70-nvm.zsh

source ${ZSHRCDIR}/70-nvm.zsh

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
