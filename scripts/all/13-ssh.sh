#!/usr/bin/env bash
# Sets up SSH config for server and user

echo -e "\n### ssh ###\n"

OSNAME=$(sed -En "s/^NAME=\"(.*)\"/\1/p" </etc/os-release)

if [[ ! "${INC_SSH}" = true ]]; then
	echo "INC_SSH is not set. Skipping 14-ssh.sh"
	exit 0
fi

echo "Install openssh-server"
if [[ "${OSNAME}" = "Fedora Linux" ]]; then
	sudo dnf install -y openssh-server
fi

if [[ ${OSNAME} = "Ubuntu" ]] || [[ ${OSNAME} = "Pop!_OS" ]] || [[ "${OSNAME}" = "Debian GNU/Linux" ]]; then
	sudo apt install -y openssh-server
fi

echo "Enabling and starting openssh-server"
sudo systemctl enable sshd
sudo systemctl start sshd

echo "Copying pub key"
[[ -d "${HOME}"/.ssh ]] || mkdir "${HOME}"/.ssh
cp "${FILESDIR}"/ssh/id_rsa.pub "${HOME}"/.ssh/

echo "Adding SSH Config"
cp "${FILESDIR}"/ssh/config "${HOME}"/.ssh/config

echo "Adding id_rsa.pub to authorized keys"
cat "${HOME}"/.ssh/id_rsa.pub >>"${HOME}"/.ssh/authorized_keys
