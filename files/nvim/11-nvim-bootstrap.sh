#!/usr/bin/env bash
# Installs python virtual env for Neovim.
# Neovim uses the nvim venv python path hardcoded in its config 
# to prevent requiring pynvim in all venvs
pyenv install $(pyenv latest -k 3)
pyenv virtualenv $(pyenv latest -k 3) nvim
pyenv activate nvim
pip install pynvim
