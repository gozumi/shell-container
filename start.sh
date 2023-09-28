#!/bin/bash

CONTAINER_NAME=shell-development

podman run \
    --name $CONTAINER_NAME \
    -d -ti \
    -v ~/.gitconfig:/home/developer/.gitconfig \
    -v ./.ssh:/home/developer/.ssh-host \
    shell-development:latest \
    /home/developer/container-start-script.sh 
