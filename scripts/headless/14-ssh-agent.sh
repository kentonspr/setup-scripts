#!/usr/bin/env bash
# Sets up ssh-agent

echo -e "\n### ssh-agent ###\n"

if [[ ! "${INC_SSH_AGENT}" = true ]]; then
	echo "INC_SSH_AGENT is not set. Skipping 14-ssh-agent.sh"
	exit 0
fi

if [ -f /usr/lib/systemd/user/ssh-agent.service ]; then
	echo -e "\n--- removing default ssh-agent service ---\n"
	sudo rm /usr/lib/systemd/user/ssh-agent.service
fi

echo -e "\n--- adding ssh-agent user service ---\n"
[ ! -d "${HOME}/.config/systemd/user" ] && mkdir -p "${HOME}/.config/systemd/user"
cp "${FILESDIR}/ssh/ssh-agent.service" "${HOME}/.config/systemd/user/ssh-agent.service"

systemctl --user enable ssh-agent
systemctl --user start ssh-agent
