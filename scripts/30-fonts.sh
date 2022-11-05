#!/usr/bin/env bash
# Installs fonts

: ${OSNAME:=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")}
: ${CODEDIR:="${HOME}/Code"}
: ${TMPDIR:="${HOME}/.tmp/setup"}

if [[ $SKIP_FONTS ]]; then
    echo "SKIP_FONTS is set. Skipping 30-fonts.sh"
    exit 0
fi

FONTSDIR=${HOME}/.local/share/fonts
echo -e "\nCleaning ${FONTSDIR}"
rm -rf ${FONTSDIR} && mkdir -p ${FONTSDIR}

echo -e "\nInstalling JetBrains Mono Fonts"
git clone --depth 1 -- https://github.com/JetBrains/JetBrainsMono.git ${CODEDIR}/public/JetBrainsMono
ln -s ${CODEDIR}/public/JetBrainsMono $FONTSDIR/JetBrainsMono

echo -e "\nInstalling Source Sans Pro Fonts"
mkdir -p ${FONTSDIR}/SourceSansPro
curl -o source_sans_pro.zip --output-dir ${TMPDIR} https://fonts.google.com/download?family=Source%20Sans%20Pro
unzip ${TMPDIR}/source_sans_pro.zip -d ${FONTSDIR}/SourceSansPro

echo -e "\nInstalling Powerline Fonts"
if [[ "$OSNAME" = "Fedora" ]]; then
    sudo dnf install powerline powerline-fonts
fi

if [[ "$OSNAME" = "Ubuntu" ]] || [[ "$OSNAME" = "Pop!_OS" ]]; then
    sudo apt install fonts-powerline
fi

echo -e "\nInstalling All-the-Icons Fonts"
git clone --depth 1 -- https://github.com/domtronn/all-the-icons.el.git ${CODEDIR}/public/all-the-icons
ln -s ${CODEDIR}/public/all-the-icons $FONTSDIR/all-the-icons

echo -e "\nEnsuring permissions for fonts are correct"
chown -R ${USER}:${USER} ${FONTSDIR}
chmod -R 0755 ${FONTSDIR}
