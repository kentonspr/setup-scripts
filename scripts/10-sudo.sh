#!/usr/bin/env bash
# Add user to sudoers with NOPASSWD

if [[ $SKIP_SUDO ]]; then
    echo "SKIP_SUDO is set. Skipping 10-sudo.sh"
    exit 0
fi

COMMAND="EDITOR=\"tee\" visudo -f /etc/sudoers.d/$USER"
echo "$USER ALL=NOPASSWD: ALL" | (sudo su -c "$COMMAND")

exit 0
