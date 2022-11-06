#!/usr/bin/env bash

if [[ ! $INC_LAPTOP_Z16 ]]; then
    echo "INC_LAPTOP_Z16 is not set. Skipping 90-laptop-z16.sh"
    exit 0
fi

if [[ $OSNAME = "Pop!_OS" ]]; then
    echo "Installing packages"
    sudo apt install -y libpam-fprintd
fi
