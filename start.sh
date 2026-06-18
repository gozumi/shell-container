#!/bin/bash

CONTAINER_NAME=shell-development
CONTAINER_DIR=$HOME/container-development

[ ! -d $CONTAINER_DIR ] && mkdir $CONTAINER_DIR
[ ! -f $CONTAINER_DIR/.zsh_history ] && touch $CONTAINER_DIR/.zsh_history

docker run -it -d \
    --name $CONTAINER_NAME \
    --memory=10g \
    --memory-reservation=4g \
    --memory-swap=10g \
    -p 2222:22 \
    -p 0.0.0.0:8100:8100 \
    -p 54320-54329:54320-54329 \
    --privileged \
    -v dind-var-lib-docker:/var/lib/docker \
    --cap-add=CAP_AUDIT_WRITE \
    -v $HOME/.ssh/id_ed25519.pub:/home/developer/.ssh/authorized_keys \
    -v $HOME/.ssh/id_ed25519.pub:/home/developer/.ssh/id_ed25519.pub \
    -v $HOME/.ssh/id_ed25519:/home/developer/.ssh/id_ed25519 \
    -v $HOME/.gitconfig:/home/developer/.gitconfig \
    -v $CONTAINER_DIR/:/home/developer/development \
    shell-development:latest \
    /usr/sbin/sshd -D -e
