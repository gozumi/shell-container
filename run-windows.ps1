podman run --name shell-development -d -v $pwd\.ssh:/home/developer/.ssh:U -v $pwd\.gitconfig:/home/developer/.gitconfig:U shell-development:latest sleep infinity
