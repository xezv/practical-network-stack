#!/usr/bin/env bash
set -euo pipefail

pacman -Syy

pacman -S --noconfirm \
    base-devel \
    git \
    gcc \
    gdb \
    cmake \
    clang \
    make \
    helix \
    inetutils \
    traceroute \
    openbsd-netcat \
    iproute2 \
    tcpdump \
    vim \
    github-cli
