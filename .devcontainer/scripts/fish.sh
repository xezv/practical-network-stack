#!/usr/bin/env bash
set -euo pipefail

pacman -S --needed --noconfirm \
    fish \
    fisher \
    starship \
    fzf \
    bat \
    exa \
    zoxide \
    fd \
    ripgrep \
    zellij

FISH_PATH=$(which fish)

if ! grep -Fxq "${FISH_PATH}" /etc/shells; then
    echo "${FISH_PATH}" | sudo tee -a /etc/shells
    echo "fish shell has been added to /etc/shells."
else
    echo "fish shell is already registered in /etc/shells."
fi

if [ "${SHELL}" != "${FISH_PATH}" ]; then
    chsh -s "${FISH_PATH}"
    chsh -s "${FISH_PATH}" "${USERNAME}"
    echo "Default shell has been changed to fish."
else
    echo "Default shell is already set to fish."
fi

sudo -u "${USERNAME}" fish -c "fisher install edc/bass"
fish -c "fisher install edc/bass"

cat <<EOF >>"${USER_HOME}/.config/fish/conf.d/starship.fish"
starship init fish | source
EOF

starship preset tokyo-night -o ${USER_HOME}/.config/starship.toml
