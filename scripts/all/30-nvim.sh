#!/usr/bin/env bash
# Installs neovim and sets it as default editor

echo -e "\n### neovim ###\n"

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

if [[ ! "${INC_NVIM}" ]]; then
	echo "INC_NVIM is not set. Skipping 30-nvim.sh"
	exit 0
fi

if [[ ! "${INC_PYTHON}" ]]; then
	echo "INC_PYTHON is not set. Exiting"
	exit 0
fi

echo -e "\n--- Installing neovim ---\n"

GITHUB_OUTPUT="$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest)"

if [[ "${OSNAME}" = "Ubuntu" ]] || [[ "${OSNAME}" = "Pop!_OS" ]] || [[ "${OSNAME}" = "Debian GNU/Linux" ]]; then
	echo -e "\n--- Ensuring installed dependencies ---\n"
	sudo apt install -y curl jq
fi

FILE=$(jq -r '.assets[] | select(.name | endswith("linux64.tar.gz")) .name' \
	<<<"${GITHUB_OUTPUT}")
URL=$(jq -r '.assets[] | select(.name | endswith("linux64.tar.gz")) .browser_download_url' \
	<<<"${GITHUB_OUTPUT}")

echo -e "\n--- Downloading neovim from $URL ---\n"
curl -LO --output-dir "${TMPDIR}" "${URL}"

echo -e "\n--- Installing $FILE ---\n"
[ ! -d "${HOME}/Apps" ] && mkdir "${HOME}/Apps"

tar xzvf "${TMPDIR}/${FILE}" --directory "${HOME}/Apps"

ln -s "${HOME}/Apps/nvim-linux64/bin/nvim" "${HOME}/.local/bin/nvim"

echo -e "\n--- update-alternatives ---\n"
sudo update-alternatives --install /usr/bin/nvim nvim "${HOME}/Apps/nvim-linux64/bin/nvim" 1
sudo update-alternatives --install /usr/bin/vim vim "${HOME}/Apps/nvim-linux64/bin/nvim" 1
sudo update-alternatives --set vim "${HOME}/Apps/nvim-linux64/bin/nvim"

echo -e "\n--- link dotfiles ---\n"
[ ! -d "${HOME}/.config" ] && mkdir "${HOME}/.config"
ln -s "${CODEDIR}/personal/dotfiles/lazyvim" "${HOME}/.config/nvim"

# echo -e "\n--- install packer ---\n"
# git clone --depth 1 "https://github.com/wbthomason/packer.nvim/${HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim"

cp "${FILESDIR}/nvim/11-nvim-bootstrap.sh" "${USER_BOOTSTRAPDIR}"
chmod +x "${USER_BOOTSTRAPDIR}/11-nvim-bootstrap.sh"
