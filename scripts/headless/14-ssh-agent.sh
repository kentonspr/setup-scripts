#!/usr/bin/env bash
# Sets up SSH agent

echo -e "\n### ssh-agent ###\n"

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

if [[ ! $INC_SSH_AGENT ]]; then
    echo "INC_SSH_AGENT is not set. Skipping 14-ssh-agent.sh"
    exit 0
fi

echo -e "\n--- adding ssh-agent user service ---\n"
[ ! -d ${HOME}/.config/systemd/user ] && mkdir -p ${HOME}/.config/systemd/user
cp ${FILESDIR}/ssh/ssh-agent.service ${HOME}/.config/systemd/user/ssh-agent.service

systemctl --user enable ssh-agent
systemctl --user start ssh-agent
