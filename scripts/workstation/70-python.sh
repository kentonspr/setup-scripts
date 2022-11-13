#!/usr/bin/env bash
# Installs pyenv & pyenv virtualenv

if [[ ! $INC_PYTHON ]]; then
    echo "INC_PYTHON is not set. Skipping 60-pyenv.sh"
    exit 0
fi

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS"]]; then
    sudo apt install -y libbz2-dev lipssl-dev libreadline-dev libsqlite3-dev tk-dev
fi

PYENV_REPO="https://github.com/pyenv/pyenv.git"
PYENV_REPO_DIR="${HOME}/.pyenv"
VENV_REPO="https://github.com/pyenv/pyenv-virtualenv.git"
VENV_REPO_DIR="${HOME}/.pyenv/plugins/pyenv-virtualenv"

echo "Cloning pyenv"
git clone --depth 1 -- ${PYENV_REPO} ${PYENV_REPO_DIR}

echo "Cloning pyenv virtualenv"
git clone --depth 1 -- ${VENV_REPO} ${VENV_REPO_DIR}

echo "Symlinking config files"
ln -s ${CODEDIR}/personal/dotfiles/zsh/zprofile.d/70-pyenv.zsh ${ZPROFILEDIR}/70-pyenv.zsh
ln -s ${CODEDIR}/personal/dotfiles/zsh/zshrc.d/70-pyenv.zsh ${ZSHRCDIR}/70-pyenv.zsh
