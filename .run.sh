#!/bin/bash

podman run -ti -v ~/.gitconfig:/home/developer/.gitconfig  my-development-environment:latest zsh
