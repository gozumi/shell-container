FROM ubuntu:latest

RUN apt-get update && apt-get install \
    sudo adduser zsh git iproute2 \
    ansible openssh-server -y

RUN mkdir /var/run/sshd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ARG USERNAME=developer
ARG HOME_DIR=/home/${USERNAME}

RUN adduser ${USERNAME}
RUN adduser --disabled-password ${USERNAME} --gecos '' ${USERNAME}

RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

EXPOSE 22

# Generate SSH host keys
RUN ssh-keygen -A

RUN mkdir ${HOME_DIR}/.ssh && chown ${USERNAME}:${USERNAME} ${HOME_DIR}/.ssh
