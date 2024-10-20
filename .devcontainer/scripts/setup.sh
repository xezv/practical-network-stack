#!/usr/bin/env bash
set -euo pipefail

echo "creating the user group"
groupadd --gid ${USER_GID} ${USERNAME}

echo "creating the user"
useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME}

echo "creating the sudoers directory"
mkdir -p /etc/sudoers.d/

echo "adding the user to the sudo group"

usermod -aG wheel "${USERNAME}"

echo "appending the sudoers file"
echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >>"/etc/sudoers.d/${USERNAME}"

echo "changing the permission of the sudoers file"
chmod 0440 "/etc/sudoers.d/${USERNAME}"

echo "changing the ownership of the home directory"
chown -R "${USERNAME}":"${USERNAME}" "${USER_HOME}"
