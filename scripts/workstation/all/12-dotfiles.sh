#!/usr/bin/env bash
# Install sops to use with vaulted passwords

echo -e "\n### dotfiles ###\n"

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

echo -e "\n--- Clone dotfiles ---\n"
cd ${CODEDIR}/personal
git clone git@github.com:kentonspr/dotfiles.git
