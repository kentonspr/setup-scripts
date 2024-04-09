#!/usr/bin/env bash
# Installs podman

echo -e "\n### podman ###\n"

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")
OSVERSION=$(cat /etc/os-release | sed -En "s/^VERSION_ID=\"(.*)\"/\1/p")

if [[ ! "${INC_PODMAN}" ]]; then
	echo "INC_PODMAN is not set. Skipping 30-podman.sh"
	exit 0
fi

echo -e "\n--- Add podman repo for latest ---\n"
if [[ "${OSNAME}" = "Ubuntu" ]] || [[ "${OSNAME}" = "Pop!_OS" ]]; then
	KEY_URL="https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/unstable/xUbuntu_${OSVERSION}/Release.key"
	SOURCES_URL="https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/unstable/xUbuntu_${OSVERSION}"

	echo "deb ${SOURCES_URL}/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:unstable.list
	curl -fsSL "${KEY_URL}" | Gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/devel_kubic_libcontainers_unstable.gpg >/dev/null
	sudo apt update
fi

echo -e "\n--- Install Packages ---\n"
if [[ "${OSNAME}" = "Ubuntu" ]] || [[ "${OSNAME}" = "Pop!_OS" ]]; then
	sudo apt install -y podman
fi
