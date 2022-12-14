#!/usr/bin/env bash
# Compiles and installs latest emacs and required plugins

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")


if [[ ! $INC_EMACS ]]; then
    echo "INC_EMACS is not set. Skipping 30-emacs.sh"
    exit 0
fi

if [[ $OSNAME = "Fedora Linux" ]]; then
    echo "Installing Dependencies"
    sudo dnf install -y mpfr-devel libmpc-devel gmp-devel libgccjit-devel autoconf texinfo libX11-devel jansson jansson-devel libXpm libXaw-devel \
         libjpeg-turbo-devel libpng-devel giflib-devel libtiff-devel gnutls-devel ncurses-devel gtk3-devel webkit2gtk3-devel
fi

if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    GCC_VERSION=$(gcc --version | grep gcc | awk -F' ' '{print $4}' | awk -F'.' '{print $1}')
    echo "Installing Dependencies"
    sudo apt install -y build-essential linux-headers-generic autoconf texinfo git libgtk-3-dev libtiff5-dev libgif-dev libjpeg-dev libpng-dev \
         libxpm-dev libncurses-dev libgnutls28-dev libgccjit0 libjansson-dev libgccjit-${GCC_VERSION}-dev
fi

echo "Cloning Repos"
# git clone https://github.com/tree-sitter/tree-sitter.git ${CODEDIR}/public/tree-sitter
git clone https://git.savannah.gnu.org/git/emacs.git ${CODEDIR}/public/emacs
git clone --depth 1 -- https://github.com/jwiegley/emacs-async ${CODEDIR}/public/emacs-async

# echo "Compiling and installing tree-sitter"
# cd ${CODEDIR}/public/tree-sitter
# make
# sudo make install

echo "Compiling and installing Emacs"
cd ${CODEDIR}/public/emacs
git checkout emacs-29
./autogen.sh
./configure --build x86_64-linux-gnu --with-mailutils --with-file-notification=inotify --with-x=yes --with-native-compilation --with-json
make clean
make all
sudo make install

echo "Compiling and installing Async"
cd ${CODEDIR}/public/emacs-async
make clean
make all
sudo make install

echo "Adding gnome files"
if [[ ! -d ${HOME}/.local/share/applications ]]; then
    mkdir -p ${HOME}/.local/share/applications
fi

# cp ${FILESDIR}/emacs/emacs.desktop ${HOME}/.local/share/applications

update-desktop-database  ${HOME}/.local/share/applications

if [[ ! -d ${HOME}/.local/share/icons/emacs ]]; then
    mkdir -p ${HOME}/.local/share/icons/emacs
fi

cp ${FILESDIR}/emacs/icons/* ${HOME}/.local/share/icons/emacs/

echo "Linking config files"
[[ ! -d ${HOME}/.emacs.d ]] && mkdir ${HOME}/.emacs.d
ln -s ${CODEDIR}/personal/dotfiles/emacs/* ${HOME}/.emacs.d/

echo "Touch custom.el"
touch ${HOME}/.emacs.d/custom.el
