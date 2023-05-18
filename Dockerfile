FROM ubuntu:lunar

RUN apt-get update

RUN apt-get install zsh git -y 

RUN adduser developer

RUN chsh -s $(which zsh)

USER developer

RUN mkdir /home/developer/git-downloads

RUN git clone https://github.com/gozumi/dotfiles.git /home/developer/git-downloads/dotfiles \
    && ln -s /home/developer/git-downloads/dotfiles/.zshrc /home/developer/.zshrc \
    && ln -s /home/developer/git-downloads/dotfiles/git-prompt.sh /home/developer/git-prompt.sh

RUN git clone https://github.com/marlonrichert/zsh-autocomplete.git /home/developer/git-downloads/zsh-autocomplete

WORKDIR /home/developer
