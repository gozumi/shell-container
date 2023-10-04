FROM ubuntu:lunar

# RUN apt-get update

# RUN apt-get install \
#     bat wget gcc git sudo tmux zsh cmake ninja-build gettext cmake unzip curl ansible \
#     -y 

ARG USERNAME=developer
# ARG HOME_DIR=/home/${USERNAME}
# ARG DOTFILES_DIR=${HOME_DIR}/git-downloads/dotfiles

RUN adduser ${USERNAME}

RUN adduser --disabled-password ${USERNAME} --gecos '' ${USERNAME}

RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# RUN chsh -s $(which zsh)

USER ${USERNAME}

# RUN wget https://github.com/neovim/neovim/archive/refs/tags/stable.tar.gz -O ${HOME_DIR}/git-downloads/nvim-stable.tar.gz
# RUN cd ${HOME_DIR}/git-downloads && \
#     tar xvf nvim-stable.tar.gz
# RUN cd ${HOME_DIR}/git-downloads/neovim-stable && \
#     make CMAKE_BUILD_TYPE=RelWithDebInfo && \
#     sudo make install

# RUN wget https://github.com/LuaLS/lua-language-server/releases/download/3.7.0/lua-language-server-3.7.0-linux-x64.tar.gz -O ${HOME_DIR}/git-downloads/lua-language-server.tar.gz
# RUN cd ${HOME_DIR}/git-downloads && \
#     mkdir lua-language-server && \
#     tar xvf lua-language-server.tar.gz -C lua-language-server

# RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -sSf | sh -s -- -y
# RUN ${HOME_DIR}/.cargo/bin/rustup component add rust-analyzer

# RUN git clone https://github.com/marlonrichert/zsh-autocomplete.git ${HOME_DIR}/git-downloads/zsh-autocomplete
# RUN git clone https://github.com/gozumi/dotfiles.git ${DOTFILES_DIR}
# RUN git clone https://github.com/tmux-plugins/tpm ${HOME_DIR}/.tmux/plugins/tpm

# RUN mkdir ${HOME_DIR}/.config
# RUN mkdir -p ${HOME_DIR}/.local/bin

# COPY --chown=${USERNAME}:${USERNAME} --chmod=755 container-start-script.sh ${HOME_DIR}/.

# RUN ln -s ${DOTFILES_DIR}/.zshrc ${HOME_DIR}/.zshrc
# RUN ln -s ${DOTFILES_DIR}/git-prompt.sh ${HOME_DIR}/git-prompt.sh
# RUN ln -s ${DOTFILES_DIR}/.tmux.conf ${HOME_DIR}/.tmux.conf
# RUN ln -s ${DOTFILES_DIR}/neovim ${HOME_DIR}/.config/nvim
# RUN ln -s ${HOME_DIR}/git-downloads/lua-language-server/bin/lua-language-server ${HOME_DIR}/.local/bin/lua-language-server

WORKDIR ${HOME_DIR}
