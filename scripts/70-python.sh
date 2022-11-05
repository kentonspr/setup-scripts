#!/usr/bin/env bash
# Installs pyenv & pyenv virtualenv

: ${ZSHRCDIR:="${ZDOTDIR}/zshrc.d"}
: ${ZPROFILEDIR:="${ZDOTDIR}/zprofile.d"}
: ${CODEDIR:="${HOME}/Code"}

if [[ $SKIP_PYTHON ]]; then
    echo "SKIP_PYTHON is set. Skipping 60-pyenv.sh"
    exit 0
fi

PYENV_REPO="https://github.com/pyenv/pyenv.git"
PYENV_REPO_DIR="${CODEDIR}/public/pyenv"
VENV_REPO="https://github.com/pyenv/pyenv-virtualenv.git"
VENV_REPO_DIR="${CODEDIR}/public/pyenv/plugins/pyenv-virtualenv"

echo "Cloning pyenv"
git clone --depth 1 -- ${PYENV_REPO} ${PYENV_REPO_DIR}

echo "Cloning pyenv virtualenv"
git clone --depth 1 -- ${VENV_REPO} ${VENV_REPO_DIR}

echo "Symlinking pyenv to ${HOME}/.pyenv"
ln -s ${PYENV_REPO_DIR} ${HOME}/.pyenv

echo "Symlinking config files"
ln -s ${CODEDIR}/dotfiles/zsh/zprofile.d/70-pyenv.zsh ${ZPROFILEDIR}/70-pyenv.zsh
ln -s ${CODEDIR}/dotfiles/zsh/zshrc.d/70-pyenv.zsh ${ZSHRCDIR}/70-pyenv.zsh
