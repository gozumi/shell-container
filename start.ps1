podman run `
    -it `
    --name shell-development `
    -v $env:USERPROFILE\.gitconfig:/home/developer/.gitconfig:U `
    -d -v $env:USERPROFILE\.ssh:/home/developer/.ssh-host:U `
    -d -v .setup.sh:/home/developer/.setup.sh:U `
    shell-development:latest `
    /home/developer/.setup.sh
