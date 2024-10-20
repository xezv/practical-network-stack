#!/usr/bin/env bash
set -euo pipefail
DOTFILES_DIR="${USER_HOME}/dotfiles"

git clone "${DOTFILES_REPO}" "${DOTFILES_DIR}"
chown -R "${USERNAME}:${USERNAME}" "${DOTFILES_DIR}"

sudo -u "${USERNAME}" bash -c "${DOTFILES_DIR}/${DOTFILES_SETUP_SH}"
