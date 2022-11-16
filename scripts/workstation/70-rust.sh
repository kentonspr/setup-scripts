#!/usr/bin/env bash
# Installs rust and sets up env

if [[ ! $INC_RUST ]]; then
    echo "INC_RUST is not set. Skipping 60-rust.sh"
    exit 0
fi

echo "Installing Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

echo "Linking PATH"
ln -s ${CODEDIR}/personal/dotfiles/zsh/zprofile.d/70-rust.zsh ${ZPROFILEDIR}/70-rust.zsh

echo "Installing rust components"
COMPONENTS="rust-src rust-analyzer rustfmt rust-docs"

for i in ${COMPONENTS}; do
    PATH="${PATH}:${HOME}/.cargo/bin" rustup component add ${i}
done

echo "Linking rust-analyzer to ${HOME}/.cargo/bin"
ln -s $(rustup which --toolchain stable rust-analyzer) ${HOME}/.cargo/bin/rust-analyzer
