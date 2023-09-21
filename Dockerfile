FROM ubuntu:lunar

RUN apt-get update

RUN apt-get install \
    bat wget gcc git neovim sudo tmux zsh cmake \
    -y 

ARG USERNAME=developer
ARG HOME_DIR=/home/${USERNAME}
ARG DOTFILES_DIR=${HOME_DIR}/git-downloads/dotfiles

RUN adduser ${USERNAME}

RUN adduser --disabled-password ${USERNAME} --gecos '' ${USERNAME}

RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN chsh -s $(which zsh)

USER ${USERNAME}

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -sSf | sh -s -- -y

RUN mkdir ${HOME_DIR}/git-downloads
RUN git clone https://github.com/marlonrichert/zsh-autocomplete.git ${HOME_DIR}/git-downloads/zsh-autocomplete
RUN git clone https://github.com/gozumi/dotfiles.git ${DOTFILES_DIR}
RUN git clone https://github.com/tmux-plugins/tpm ${HOME_DIR}/.tmux/plugins/tpm
RUN wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz -O ${HOME_DIR}/git-downloads/nvim-linux64.tar.gz
RUN cd ${HOME_DIR}/git-downloads && \
    tar xvf nvim-linux64.tar.gz
RUN wget https://github.com/LuaLS/lua-language-server/releases/download/3.7.0/lua-language-server-3.7.0-linux-x64.tar.gz -O ${HOME_DIR}/git-downloads/lua-language-server.tar.gz
RUN cd ${HOME_DIR}/git-downloads && \
    mkdir lua-language-server && \
    tar xvf lua-language-server.tar.gz -C lua-language-server
RUN mkdir -p ${HOME_DIR}/.config/nvim
RUN mkdir -p ${HOME_DIR}/.local/bin

RUN ln -s ${DOTFILES_DIR}/.zshrc ${HOME_DIR}/.zshrc
RUN ln -s ${DOTFILES_DIR}/git-prompt.sh ${HOME_DIR}/git-prompt.sh
RUN ln -s ${DOTFILES_DIR}/.tmux.conf ${HOME_DIR}/.tmux.conf
RUN ln -s ${DOTFILES_DIR}/neovim/init.lua ${HOME_DIR}/.config/nvim/init.lua
RUN ln -s ${HOME_DIR}/git-downloads/nvim-linux64/bin/nvim ${HOME_DIR}/.local/bin/nvim
RUN ln -s ${HOME_DIR}/git-downloads/lua-language-server/bin/lua-language-server ${HOME_DIR}/.local/bin/lua-language-server

WORKDIR ${HOME_DIR}
