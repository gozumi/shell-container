FROM ubuntu:latest

RUN apt-get update

RUN apt-get install sudo adduser zsh git ansible -y

ARG USERNAME=developer
ARG HOME_DIR=/home/${USERNAME}

RUN adduser ${USERNAME}

RUN adduser --disabled-password ${USERNAME} --gecos '' ${USERNAME}

RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN chsh -s $(which zsh)

USER ${USERNAME}

RUN mkdir ${HOME_DIR}/development

WORKDIR ${HOME_DIR}
