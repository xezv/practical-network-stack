FROM --platform=amd64 archlinux:latest

ARG USERNAME=${USERNAME}
ARG USER_GID=${USER_GID}
ARG USER_UID=${USER_UID}
ARG USER_HOME=/home/${USERNAME}
ARG HELIX_VERSION=${HELIX_VERSION}
ARG DOTFILES_REPO=${DOTFILES_REPO}
ARG DOTFILES_SETUP_SH=${DOTFILES_SETUP_SH}

# ENV LANG=en_US.UTF-8
# ENV LANGUAGE=en_US:en
# ENV LC_ALL=en_US.UTF-8

# # copy the config files from the host machine to the container
# COPY --chown=${USERNAME}:${USERNAME} ./home/.config ${USER_HOME}/.config

# COPY scripts dir 
COPY ./scripts/setup.sh /tmp/scripts/setup.sh
RUN chmod +x /tmp/scripts/setup.sh && /tmp/scripts/setup.sh

COPY ./scripts/install.sh /tmp/scripts/install.sh
RUN chmod +x /tmp/scripts/install.sh && /tmp/scripts/install.sh

# switch to the user
# USER ${USERNAME}
COPY ./scripts/fish.sh /tmp/scripts/fish.sh
RUN chmod +x /tmp/scripts/fish.sh && /tmp/scripts/fish.sh

COPY ./scripts/dotfiles.sh /tmp/scripts/dotfiles.sh
RUN chmod +x /tmp/scripts/dotfiles.sh && /tmp/scripts/dotfiles.sh


# make all the scripts executable and move to /tmp/
# RUN find /tmp/scripts/ -type f -name "*.sh" -exec chmod +x {} \; -exec mv {} /tmp/scripts/ \;

# SHELL ["/bin/bash", "-c"]

# remove the `.tmp` dir. don't use `tmp` because it's a reserved directory name
# e.g. `CodeLLDB` is not working properly when the `tmp` directory is removed
RUN rm -rf /tmp/scripts/

# keep the container running
# CMD ["bash"] is ok but if it's not interactive mode, the container will exit
CMD ["tail", "-f", "/dev/null"]