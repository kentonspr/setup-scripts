#!/usr/bin/env bash
# Installs and configures alacritty terminal
# Requires rust cargo

if [[ ! $INC_RUST ]] || [[ ! $INC_ALACRITTY ]]; then
    echo -e "\n--- INC_ALACRITTY is not set. Skipping 71-alacritty.sh ---\n"
    exit 0
fi

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")
REPO="https://github.com/alacritty/alacritty.git"
REPODIR=${CODEDIR}/public/alacritty
CONFIGDIR=${HOME}/.config/alacritty

if [[ $OSNAME = "Fedora Linux" ]]; then
    echo -e "\n--- installing dependencies ---\n"
    sudo dnf install -y cmake freetype-devel fontconfig-devel libxcb-devel libxkbcommon-devel g++
fi

if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    echo -e "\n--- installing dependencies ---\n"
    sudo apt install -y gzip cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev
fi

echo -e "\n--- cloning repo"
git clone --depth 1 -- ${REPO} ${REPODIR}

echo -e "\n--- building alacritty ---\n"
cd ${REPODIR}
PATH="${PATH}:${HOME}/.cargo/bin" cargo build --release

echo -e "\n--- install term info ---\n"
tic -xe alacritty,alacritty-direct extra/alacritty.info

echo -e "\n--- symlink binary ---\n"
if [[ ! -d ${HOME}/.local/bin ]]; then
    mkdir -p ${HOME}/.local/bin
fi

ln -s ${REPODIR}/target/release/alacritty ${HOME}/.local/bin/alacritty

echo -e "\n--- copy icon ---\n"
if [[ ! -d ${HOME}/.local/share/icons ]]; then
    mkdir -p ${HOME}/.local/share/icons
fi

cp ${REPODIR}/extra/logo/alacritty-term.svg ${HOME}/.local/share/icons/Alacritty.svg

echo -e "\n--- installing desktop file ---\n"
cp ${REPODIR}/extra/linux/Alacritty.desktop ${HOME}/.local/share/applications/
update-desktop-database ${HOME}/.local/share/applications

echo -e "\n--- installing man pages ---\n"
gzip -c ${REPODIR}/extra/alacritty.man | sudo tee ${HOME}/.local/share/man/man1/alacritty.1.gz > /dev/null
gzip -c ${REPODIR}/extra/alacritty-msg.man | sudo tee ${HOME}/.local/share/man/man1/alacritty-msg.1.gz > /dev/null

echo -e "\n--- install shell completions ---\n"
cp ${REPODIR}/extra/completions/_alacritty ${ZDOTDIR}/functions/_alacritty

echo -e "\n--- symlink config ---\n"
mkdir -p ${CONFIGDIR}

ln -s ${CODEDIR}/personal/dotfiles/alacritty/alacritty.yml ${CONFIGDIR}/alacritty.yml
ln -s ${CODEDIR}/personal/dotfiles/zsh/zshrc.d/10-aliases.zsh ${ZDOTDIR}/zshrc.d/10-alacritty.zsh

echo -e "\n--- update alternatives ---\n"
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator ${HOME}/.local/bin/alacritty 50
sudo update-alternatives --set x-terminal-emulator ${HOME}/.local/bin/alacritty
