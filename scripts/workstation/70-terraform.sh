#!/usr/bin/env bash
# Installs tfenv

if [[ ! $INC_TERRAFORM ]]; then
    echo "INC_TERRAFORM is not set. Skipping 70-terraform.sh"
    exit 0
fi

TFENV_DIR=${CODEDIR}/public/tfenv

echo -e "\n--- installing tfenv ---\n"
git clone --depth=1 https://github.com/tfutils/tfenv.git ${TFENV_DIR}

[ ! -d ${HOME}/.local/bin] && mkdir -p ${HOME}/.local/bin
ln -s ${TFENV_DIR}/bin/* ${HOME}/.local/bin/

echo "Symlinking config files"
ln -s ${CODEDIR}/personal/dotfiles/zsh/zshrc.d/80-terraform.zsh ${ZPROFILEDIR}/80-terraform.zsh
