#!/usr/bin/env bash
# Sets up SSH agent

echo -e "\n### ssh-agent ###\n"

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

if [[ ! $INC_SOPS ]]; then
    echo "INC_SSH_AGENT is not set. Skipping 14-ssh-agent.sh"
    exit 0
fi

