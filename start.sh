#!/bin/bash

CONTAINER_NAME=shell-development

podman run \
    --name $CONTAINER_NAME \
    -d -ti \
    --memory=5g \
    --memory-reservation=4g \
    --cap-add=CAP_AUDIT_WRITE \
    -v ~/.gitconfig:/home/developer/.gitconfig \
    -v ./.ssh:/home/developer/.ssh-host \
    -v ./:/home/developer/development \
    shell-development:latest \
    zsh
    # /home/developer/container-start-script.sh 
