#!/usr/bin/env bash

echo -e "\n--- mainline_kernel.sh ---\n"

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

if [[ $OSNAME != "Ubuntu" ]]; then
    echo "This can only be run for ubuntu machines"
    exit 0
fi

if [[ -z ${1: x} ]]; then
   echo "Needs a kernel version argument" 
fi

VERSION=${1}

PPA_URL="https://kernel.ubuntu.com/~kernel-ppa/mainline/v${VERSION}/amd64/"
DEB_DIR=${HOME}/kernels/${VERSION}

echo -e "\n--- downloadking kernel version ${1} ---\n"

mkdir -p ${DEB_DIR}
FILES=$(curl -s ${PPA_URL} | grep deb | sed -n 's/.*href="\([^"]*\).*/\1/p')

for FILE in $(echo $FILES | tr '\n' ' '); do
    curl ${PPA_URL}${FILE} -o ${DEB_DIR}/${FILE}
done

echo -e "\n--- install new kernel packages ---\n"
cd ${DEB_DIR}
sudo dpkg -i $(echo $FILES | tr '\n' ' ')
