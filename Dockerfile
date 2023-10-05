FROM ubuntu:lunar

RUN apt-get update

RUN apt-get install sudo adduser zsh -y

ARG USERNAME=developer
ARG HOME_DIR=/home/${USERNAME}

RUN apt-get install sudo adduser ansible -y

RUN adduser ${USERNAME}

RUN adduser --disabled-password ${USERNAME} --gecos '' ${USERNAME}

RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN chsh -s $(which zsh)

USER ${USERNAME}

WORKDIR ${HOME_DIR}
