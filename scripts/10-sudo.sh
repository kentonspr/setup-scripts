#!/usr/bin/env bash
# Add user to sudoers with NOPASSWD

if [ -n ${SKIP_SUDO} ]; then
    echo "SKIP_SUDO is set. Skipping 10-sudo.sh"
    exit 0
fi

COMMAND="EDITOR=\"tee\" visudo -f /etc/sudoers.d/$USER"

echo "Adding sudoers file for $USER"
if [ $PHASE -eq 1]; then
    echo "$USER ALL=NOPASSWD: ALL" | (sudo su -c "$COMMAND")
fi

exit 0
