#!/usr/bin/env bash
# This is the initial script to run on first boot.

echo "*** setup.sh - Begin ***"
export TMPDIR="${HOME}/.tmp/setup"
export FILESDIR="${PWD}/files"
export CODEDIR="${HOME}/Code"
export ZDOTDIR="${HOME}/.zsh"
export ZSHRCDIR="${ZDOTDIR}/zshrc.d"
export ZPROFILEDIR="${ZDOTDIR}/zprofile.d"
export OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

echo "OS = $OSNAME"

echo "Updating system before proceeding"
if [ "$OSNAME" = "Fedora Linux" ]; then
    sudo dnf upgrade --refresh -y
fi

if [ "$OSNAME" = "Ubuntu" ]; then
    sudo apt update
    sudo apt dist-upgrade -y
    sudo apt autoremove -y
fi

chmod +x ./scripts/*
mkdir -p ${TMPDIR}

for i in $(find ./scripts/ -type f -name '*.sh'|sort); do
    echo "$(date) - Executing ${i}"
    FILENAME=$(basename -- "$i")

    ${i} | tee -a ${TMPDIR}/${FILENAME}.log 2>&1

    echo "$(date) - END of ${i}\n"
done

echo "*** setup.sh - End ***"
