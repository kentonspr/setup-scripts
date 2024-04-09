#!/usr/bin/env bash
# Add user to sudoers with NOPASSWD

echo -e "\n### sudo ###\n"

if [[ ! ${INC_SUDO} ]]; then
	echo "INC_SUDO is not set. Skipping 10-sudo.sh"
	exit 0
fi

COMMAND="EDITOR=\"tee\" visudo -f /etc/sudoers.d/${USER}"
echo "${USER} ALL=NOPASSWD: ALL" | (sudo su -c "${COMMAND}")

exit 0
