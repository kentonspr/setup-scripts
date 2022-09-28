#!/usr/bin/env bash
# This is the initial script to run on first boot.

echo "*** setup.sh - Begin ***"
# The first phase creates creates all pre-setup stuff. Add repos, append packages
# to the apt list, etc...

# List of base packages that will be installed. All other setup scripts will append
# to this list if needed
export TMPDIR="${HOME}/.tmp/setup"
export FILESDIR="../../files"
export CODEDIR="${HOME}/Code"
export ZDOTDIR="${HOME}/.zsh"
export ZSHRCDIR="${ZDOTDIR}/zshrc.d"
export ZPROFILEDIR="${ZDOTDIR}/zprofile.d"
export OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

echo "OS = $OSNAME"

UBUNTU_PACKAGES="git net-tools jq unzip zip nfs-utils ripgrep fzf tree whois"
FEDORA_PACKAGES="git net-tools jq unzip zip nfs-utils ripgrep fzf tree whois"

echo "Updating system and installing packages"
if [ "$OSNAME" = "Fedora Linux"]; then
    sudo dnf upgrade --refresh -y
fi

if [ "$OSNAME" = "Ubuntu"]; then
    sudo apt update
    sudo apt dist-upgrade -y
    sudo apt autoremove -y
fi

chmod +x ./scripts/*

for i in $(find ./scripts/ -type f -name '*.sh'|sort); do
    echo "$(date) - Executing ${i}"

    ${i} | tee -a ${TMPDIR}/${i}.log 2>&1

    echo "$(date) - END of ${i}\n"
done

echo "*** setup.sh - End ***"


# - com.bitwarden.desktop # Password Manager
# - com.discordapp.Discord # Chat
# - com.transmissionbt.Transmission # BitTorrent Client
# - com.valvesoftware.Steam # Games
# - net.displaycal.DisplayCAL # Display Calibration
# - org.remmina.Remmina # Remote Desktop
# - org.signal.Signal # Encrypted Chat
# - org.mozilla.Thunderbird # Email
# - org.gnome.GHex # Hex Editor
# - org.gnome.meld # Graphical Diff tool
