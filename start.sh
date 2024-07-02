#!/bin/bash

CONTAINER_NAME=shell-development

podman run -it -d --rm \
    --name $CONTAINER_NAME \
    --memory=5g \
    --memory-reservation=4g \
    -p 2222:22 \
    --cap-add=CAP_AUDIT_WRITE \
    -v ./.ssh/id_ed25519.pub:/home/developer/.ssh/authorized_keys \
    -v ./.ssh/id_ed25519.pub:/home/developer/.ssh/id_ed25519.pub \
    -v ./.ssh/id_ed25519:/home/developer/.ssh/id_ed25519 \
    -v ~/.gitconfig:/home/developer/.gitconfig \
    -v ./:/home/developer/development \
    shell-development:latest \
    /usr/sbin/sshd -D -e

