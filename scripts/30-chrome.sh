#!/usr/bin/env bash
# Installs chrome

if [ -z ${SKIP_CHROME} ]; then
    echo "SKIP_CHROME is set. Skipping 30-chrome.sh"
    exit 0
fi

if [ "$OSNAME" = "Fedora Linux" ]; then
    echo "Downloading and installing chrome"
    sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub
    curl -O --output-dir ${TMPDIR} https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

    sudo dnf install -y ${TMPDIR}/google-chrome-stable_current_x86_64.rpm
fi

if [ "$OSNAME" = "Ubuntu" ]; then
    echo "Downloading and installing chrome"
    curl -O --output-dir ${TMPDIR} https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

    sudo apt install -y ${TMPDIR}/google-chrome-stable_current_x86_64.rpm
fi
