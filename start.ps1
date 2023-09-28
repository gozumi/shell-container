podman run `
    --name shell-development `
    -v $env:USERPROFILE\.gitconfig:/home/developer/.gitconfig:U `
    -d -v $env:USERPROFILE\.ssh:/home/developer/.ssh-host:U `
    shell-development:latest `
    /home/developer/container-start-script.sh
