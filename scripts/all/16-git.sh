#!/usr/bin/env bash
# Installs and configures git

echo -e "\n### git ###\n"

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

if [[ ! ${INC_GIT} ]]; then
	echo "INC_GIT is not set. Skipping 15-git.sh"
	exit 0
fi

if [[ ${OSNAME} = "Fedora Linux" ]]; then
	echo "Ensuring git dependencies are installed"
	sudo dnf install git
fi

if [[ ${OSNAME} = "Ubuntu" ]] || [[ ${OSNAME} = "Pop!_OS" ]]; then
	echo "Ensuring git dependencies are installed"
	sudo apt install git
fi

echo -e "\n--- Setting up git private key ---\n"
[[ ! -d "${HOME}/.ssh" ]] && mkdir "${HOME}/.ssh"
sops -d --extract '["github_rsa_priv_key"]' "${FILESDIR}/ssh/vault.sops.yml" >"${HOME}/.ssh/github"
chmod 600 "${HOME}/.ssh/github"

echo -e "\n--- Copying pub key\n"
cp "${FILESDIR}/ssh/github.pub" "${HOME}/.ssh/"

echo -e "\n--- Adding github key to agent ---\n"

ssh-add "${HOME}/.ssh/github"
