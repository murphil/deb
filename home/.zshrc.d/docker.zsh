alias d="docker"
alias di="docker images"
alias drmi="docker rmi"
alias dt="docker tag"
alias dp="docker ps"
alias dpa="docker ps -a"
alias dl="docker logs -ft"
alias dpl="docker pull"
alias dps="docker push"
alias drr="docker run --rm -v \$(pwd):/world"
alias dr="docker run --rm -it -v \$(pwd):/world"
alias dcs="docker container stop"
alias dcr="docker container rm"
alias dsp="docker system prune -f"
alias dspa="docker system prune --all --force --volumes"
alias dvi="docker volume inspect"
alias dvr="docker volume rm"
alias dvp="docker volume prune"
alias dvl="docker volume ls"
alias dvc="docker volume create"
alias dsv="docker save"
alias dld="docker load"
alias dh="docker history"
alias dhl="docker history --no-trunc"
alias dis="docker inspect"
alias dc="docker-compose"
alias dcu="docker-compose up"
alias dcud="docker-compose up -d"
alias dcd="docker-compose down"

function da {
    if [ $# -gt 1 ]; then
        docker exec -it $@
    else
        docker exec -it $1 /bin/sh -c "[ -e /bin/zsh ] && /bin/zsh || [ -e /bin/bash ] && /bin/bash || /bin/sh"
    fi
}

function dcsr {
    local i
    for i in $*
        docker container stop $i && docker container rm $i
}
