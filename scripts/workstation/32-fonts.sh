#!/usr/bin/env bash
# Installs fonts

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

if [[ ! $INC_FONTS ]]; then
    echo "INC_FONTS is not set. Skipping 30-fonts.sh"
    exit 0
fi

if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    echo -e "\n--- Ensuring installed dependencies ---\n"
    sudo apt install -y curl jq unzip
fi

FONTSDIR=${HOME}/.local/share/fonts
echo -e "\nCleaning ${FONTSDIR}"
rm -rf ${FONTSDIR} && mkdir -p ${FONTSDIR}

echo -e "\nInstalling JetBrains Mono Fonts"
GITHUB_OUTPUT=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest) 

FILE=$(jq -r '.assets[] | select(.name | endswith("JetBrainsMono.zip")) .name' \
          <<< $GITHUB_OUTPUT)
URL=$(jq -r '.assets[] | select(.name | endswith("JetBrainsMono.zip")) .browser_download_url' \
         <<< $GITHUB_OUTPUT)

echo -e "\n--- Downloading JetBrains Mono Nerd Font from $URL ---\n"
curl -LO --output-dir ${TMPDIR} ${URL}

echo -e "\n--- Unzip $FILE ---\n"
mkdir ${FONTSDIR}/JetBrainsMono
unzip ${TMPDIR}/${FILE} -d ${FONTSDIR}/JetBrainsMono

echo -e "\nInstalling Source Sans Pro Fonts"
mkdir -p ${FONTSDIR}/SourceSansPro
curl -o source_sans_pro.zip --output-dir ${TMPDIR} https://fonts.google.com/download?family=Source%20Sans%20Pro
unzip ${TMPDIR}/source_sans_pro.zip -d ${FONTSDIR}/SourceSansPro

echo -e "\nInstalling Powerline Fonts"
if [[ $OSNAME = "Fedora" ]]; then
    sudo dnf install powerline powerline-fonts
fi

if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    sudo apt install fonts-powerline
fi

echo -e "\nInstalling All-the-Icons Fonts"
git clone --depth 1 -- https://github.com/domtronn/all-the-icons.el.git ${CODEDIR}/public/all-the-icons
ln -s ${CODEDIR}/public/all-the-icons $FONTSDIR/all-the-icons

echo -e "\nEnsuring permissions for fonts are correct"
chown -R ${USER}:${USER} ${FONTSDIR}
chmod -R 0755 ${FONTSDIR}
