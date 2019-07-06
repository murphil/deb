alias dk="docker"
alias di="docker images"
alias drmi="docker rmi"
alias dp="docker ps"
alias dpa="docker ps -a"
alias dl="docker logs -ft"
alias dpl="docker pull"
alias dr="docker run --rm -t -i -d"
alias drr="docker run --rm -v \$(pwd):/world"
alias dri="docker run --rm -t -i -v \$(pwd):/world"
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
alias dcu="docker-compose up"
alias dcud="docker-compose up -d"
alias dcd="docker-compose down"

function da {
    docker exec -it $1          \
        /bin/sh -c "[ -e /bin/zsh ] && /bin/zsh || [ -e /bin/bash ] && /bin/bash || /bin/sh"
}

function dcsr {
    docker container stop $1 && docker container rm $1
}

function dvbk {
    local i
    for i in $*
        docker run --rm -it -v $(pwd):/backup -v ${i}:/data alpine  tar zcvf /backup/${i}_`date +%Y%m%d%H%M%S`.tar.gz -C /data .
}

function dvrs {
    docker volume create $2
    docker run --rm -it -v $(pwd):/backup -v $2:/data alpine  tar zxvf /backup/$1 -C /data
}

function dvis {
    docker run -it --rm -v $1:/data -w /data alpine
}
