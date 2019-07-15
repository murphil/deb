alias pc='proxychains4 -q'
# -L 只追踪相对链接 -E 添加 html 后缀
alias sget='wget -m -k -E -p -np -e robots=off'
alias aria2rpc='aria2c --max-connection-per-server=8 --min-split-size=10M --enable-rpc --rpc-listen-all=true --rpc-allow-origin-all'
alias lo="lsof -nP -i"

#[Esc][h] man 当前命令时，显示简短说明
alias run-help >&/dev/null && unalias run-help
autoload run-help

#历史命令 top10
alias top10='print -l  ${(o)history%% *} | uniq -c | sort -nr | head -n 10'

function timeconv { date -d @$1 +"%Y-%m-%d %T" }

function srh {
    grep -rnw '.' -e $1
}

function runmd {
    local i
    for i in $*
        awk '/```/{f=0} f; /```bash/{f=1}' ${i} | /bin/bash -ex
}

# 查找大文件
function findBigFiles {
    find . -type f -size +$1 -print0 | xargs -0 du -h | sort -nr
}

show-alias () {
    alias | grep ${1:-'.*'} | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort
}

function slam {
    local n=0
    until eval $*
    do
        n=$[$n+1]
        echo "$fg_bold[red]...$n...$reset_color $*"
        sleep 1
    done
}

function receipt {
    local msg
    local err
    if ! msg="$(eval $* 2>&1)" ; then
        err=1
    fi
    local payload
    if [ -z $err ] ; then
        payload=":tada: \`$*\` "
    else
        payload=":sob: \`$*\`\n\t $msg"
    fi
    send-msg $payload
}

function send-msg {
    local payload="$(whoami)@$(hostname):__$(pwd)__\n"
    payload+=$1
    curl --request POST \
        --url $WEBHOOK_URL \
        --header 'content-type: application/json' \
        --data "{\"text\": \"$payload\"}"
}