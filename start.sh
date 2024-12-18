#!/bin/bash

CONTAINER_NAME=shell-development
CONTAINER_DIR=$HOME/container-development

[ ! -d $CONTAINER_DIR ] && mkdir $CONTAINER_DIR
[ ! -f $CONTAINER_DIR/.zsh_history ] && touch $CONTAINER_DIR/.zsh_history

podman run -it -d \
    --name $CONTAINER_NAME \
    --memory=5g \
    --memory-reservation=4g \
    -p 2222:22 \
    -p 8080:8080 \
    -p 3000:3000 \
    --cap-add=CAP_AUDIT_WRITE \
    -v $HOME/.ssh/id_ed25519.pub:/home/developer/.ssh/authorized_keys \
    -v $HOME/.ssh/id_ed25519.pub:/home/developer/.ssh/id_ed25519.pub \
    -v $HOME/.ssh/id_ed25519:/home/developer/.ssh/id_ed25519 \
    -v $HOME/.gitconfig:/home/developer/.gitconfig \
    -v $CONTAINER_DIR/:/home/developer/development \
    shell-development:latest \
    /usr/sbin/sshd -D -e

