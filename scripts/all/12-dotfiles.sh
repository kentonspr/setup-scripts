#!/usr/bin/env bash
# Install sops to use with vaulted passwords

echo -e "\n### dotfiles ###\n"

if [[ ! "${INC_DOTFILES}" ]]; then
	echo "INC_DOTFILES is not set. Skipping 11-dotfiles.sh"
	exit 0
fi

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

echo -e "\n--- Clone dotfiles ---\n"
cd "${CODEDIR}/personal" || exit
git clone https://github.com/kentonspr/dotfiles.git
