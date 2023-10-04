#!/bin/bash

if [ ! -d ".ssh" ]; then
    sudo cp -r .ssh-host .ssh
    sudo chown -R developer:developer .ssh
    chmod 600 .ssh/id_ed25519
    chmod 644 .ssh/id_ed25519.pub
fi

sudo apt-get install git

git clone git@github.com:gozumi/development-vm.git >>~/setup.log 2>&1

development-vm/install.sh >>~/setup.log 2>&1

sleep infinity
