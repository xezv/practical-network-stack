#!/usr/bin/env bash
set -euo pipefail

pacman -S --needed --noconfirm \
    python \
    uv \
    ruff
