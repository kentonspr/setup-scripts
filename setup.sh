#!/usr/bin/env bash
# This is the initial script to run on first boot.

echo "*** setup.sh - Begin ***"

source env.config
DEVICE=$1
source env.${DEVICE}

if [[ -z ${SETUP_GROUPS+x} ]]; then
    SETUP_GROUPS="all"
else
    SETUP_GROUPS+=( "all" )
fi

echo "OS = $OSNAME"

echo "Updating system before proceeding"
if [ $OSNAME = "Fedora Linux" ]; then
    sudo dnf upgrade --refresh -y
fi

if [ $OSNAME = "Ubuntu" ] || [ $OSNAME = "Pop!_OS" ]; then
    sudo apt update
    sudo apt dist-upgrade -y
    sudo apt autoremove -y
fi

echo "Run setup scripts"
mkdir -p ${TMPDIR}
SETUP_SCRIPTS=()

# Get list of all scripts for device groups
for group in ${SETUP_GROUPS[@]}; do
    chmod +x ./scripts/${group}/*
    for script in $(find ./scripts/${group}/ -type f -name '*.sh'|sort); do
        SETUP_SCRIPTS+=("$script")
    done
done

echo -e "Setup scripts -\n${SETUP_SCRIPTS[@]}"
IFS=$'\n' SORTED_SCRIPTS=($(sort <<<"${SETUP_SCRIPTS[*]}"))
unset IFS
echo -e "\nSorted -\n${SORTED_SCRIPTS[@]}\n"

for i in ${SORTED_SCRIPTS[@]}; do
    echo -e "START ${i} - $(date)\n"
    FILENAME=$(basename -- "$i")

    ${i} | tee -a ${TMPDIR}/${FILENAME}.log

    echo -e "\nEND ${i} - $(date)"
    echo -e "\n##########\n"
done

echo "*** setup.sh - End ***"
