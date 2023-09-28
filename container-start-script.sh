#!/bin/bash

SSH_CONFIG_DIR=.ssh

if [ ! -d "$SSH_CONFIG_DIR" ]; then
    sudo cp -r .ssh-host .ssh
    sudo chown -R developer:developer .ssh
fi

sleep infinity
