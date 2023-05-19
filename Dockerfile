FROM ubuntu:lunar

RUN apt-get update

RUN apt-get install \
    bat git neovim zsh \
    -y 
ARG USERNAME=developer
ARG USER_UID=${USER_UID}
ARG USER_GID=${USER_GID}
ARG USER_GROUP_ID=${USER_GID}

RUN echo "user ${USER_UID}"
RUN echo "group ${USER_GID}"
RUN addgroup --gid ${USER_GROUP_ID} ${USERNAME}
RUN adduser ${USERNAME} --uid ${USER_UID} --gid ${USER_GROUP_ID}

RUN chsh -s $(which zsh)

USER ${USERNAME}

RUN mkdir /home/${USERNAME}/git-downloads

RUN git clone https://github.com/gozumi/dotfiles.git /home/${USERNAME}/git-downloads/dotfiles \
    && ln -s /home/${USERNAME}/git-downloads/dotfiles/.zshrc /home/${USERNAME}/.zshrc \
    && ln -s /home/${USERNAME}/git-downloads/dotfiles/git-prompt.sh /home/${USERNAME}/git-prompt.sh

RUN git clone https://github.com/marlonrichert/zsh-autocomplete.git /home/${USERNAME}/git-downloads/zsh-autocomplete

WORKDIR /home/${USERNAME}
