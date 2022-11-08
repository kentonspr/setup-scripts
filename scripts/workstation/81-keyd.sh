#!/usr/bin/env bash
# Installs keyd for mapping keys in kernal

if [[ ! $INC_KEYD ]]; then
    echo "INC_KEYD is not set. Skipping 81-keyd.sh"
    exit 0
fi

CLONEDIR=${CODEDIR}/public/keyd

echo "Installing keyd"
git clone https://github.com/rvaiya/keyd ${CLONEDIR}
cd ${CLONEDIR}
make
sudo make install
sudo systemctl enable keyd
sudo systemctl start keyd

echo "Linking config file"
[[ ! -d /etc/keyd ]] && sudo mkdir /etc/keyd
sudo ln -s ${DOTFILESDIR}/keyd/default.conf /etc/keyd/default.conf

sudo keyd reload
