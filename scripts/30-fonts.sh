#!/usr/bin/env bash
# Installs fonts

if [[ $SKIP_FONTS ]]; then
    echo "SKIP_FONTS is set. Skipping 30-fonts.sh"
    exit 0
fi

FONTSDIR=${HOME}/.local/share/fonts
echo "Cleaning ${FONTSDIR}"
rm -rf ${FONTSDIR} && mkdir -p ${FONTSDIR}

echo "Installing JetBrains Mono Fonts"
git clone --depth 1 -- https://github.com/JetBrains/JetBrainsMono.git ${CODEDIR}/public/JetBrainsMono
ln -s ${CODEDIR}/public/JetBrainsMono $FONTSDIR/JetBrainsMono

echo "Installing Source Sans Pro Fonts"
mkdir -p ${FONTSDIR}/SourceSansPro
curl -o source_sans_pro.zip --output-dir ${TMPDIR} https://fonts.google.com/download?family=Source%20Sans%20Pro
unzip ${TMPDIR}/source_sans_pro.zip -d ${FONTSDIR}/SourceSansPro

echo "Installing Powerline Fonts"
if [ "$OSNAME" = "Fedora" ]; then
    sudo dnf install powerline powerline-fonts
fi

if [ "$OSNAME" = "Ubuntu" ]; then
    sudo apt install fonts-powerline
fi

echo "Installing All-the-Icons Fonts"
git clone --depth 1 -- https://github.com/domtronn/all-the-icons.el.git ${CODEDIR}/public/all-the-icons
ln -s ${CODEDIR}/public/all-the-icons $FONTSDIR/all-the-icons

echo "Ensuring permissions for fonts are correct"
chown -R ${USER}:${USER} ${FONTSDIR}
chmod -R -0755 ${FONTSDIR}
