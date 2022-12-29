#!/usr/bin/env bash
# Installs and configures alacritty terminal
# Requires rust cargo

if [[ ! $INC_RUST ]] || [[ ! $INC_ALACRITTY ]]; then
    echo "INC_ALACRITTY is not set. Skipping 71-alacritty.sh"
    exit 0
fi

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")
REPO="https://github.com/alacritty/alacritty.git"
REPODIR=${CODEDIR}/public/alacritty

if [[ $OSNAME = "Fedora Linux" ]]; then
    echo "Installing dependencies"
    sudo dnf install -y cmake freetype-devel fontconfig-devel libxcb-devel libxkbcommon-devel g++
fi

if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    echo "Installing dependencies"
    sudo apt install -y gzip cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev
fi

echo "Cloning repo"
git clone --depth 1 -- ${REPO} ${REPODIR}

echo "Building alacritty"
cd ${REPODIR}
PATH="${PATH}:${HOME}/.cargo/bin" cargo build --release

echo "Install term info"
tic -xe alacritty,alacritty-direct extra/alacritty.info

echo "Symlink binary"
if [[ ! -d ${HOME}/.local/bin ]]; then
    mkdir -p ${HOME}/.local/bin
fi

ln -s ${REPODIR}/target/release/alacritty ${HOME}/.local/bin/alacritty

echo "Copy icon"
if [[ ! -d ${HOME}/.local/share/icons ]]; then
    mkdir -p ${HOME}/.local/share/icons
fi

cp ${REPODIR}/extra/logo/alacritty-term.svg ${HOME}/.local/share/icons/Alacritty.svg

echo "Installing desktop file"
cp ${REPODIR}/extra/linux/Alacritty.desktop ${HOME}/.local/share/applications/
update-desktop-database ${HOME}/.local/share/applications

echo "Installing man pages"
gzip -c ${REPODIR}/extra/alacritty.man | sudo tee ${HOME}/.local/share/man/man1/alacritty.1.gz > /dev/null
gzip -c ${REPODIR}/extra/alacritty-msg.man | sudo tee ${HOME}/.local/share/man/man1/alacritty-msg.1.gz > /dev/null

echo "Install shell completions"
cp ${REPODIR}/extra/completions/_alacritty ${ZDOTDIR}/functions/_alacritty
