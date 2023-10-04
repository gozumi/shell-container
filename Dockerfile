FROM ubuntu:lunar

RUN apt-get update

RUN apt-get install adduser

ARG USERNAME=developer

RUN adduser ${USERNAME}

RUN adduser --disabled-password ${USERNAME} --gecos '' ${USERNAME}

RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USERNAME}

WORKDIR ${HOME_DIR}
