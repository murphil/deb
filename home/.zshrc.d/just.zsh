alias j='just'

_comp_just () {
    alias justl="\just --list"
    alias juste="\just --evaluate"

    local -a subcmds

    while read -r line ; do
        if [[ ! $line == Available* ]] ;
        then
            #subcmds+=(${line/[[:space:]]*\#/:})
            subcmds+=(${line/[[:space:]]*})
        fi
    done < <(just --list)

    _describe 'command' subcmds
}

compdef _comp_just just

_comp_task () {
    local -a subcmds
    for i in $(ycat -oj Taskfile.yml | jq -r '.tasks | keys | join("\n")'); do
        subcmds+=($i)
    done
    _describe 'tasks' subcmds
}

compdef _comp_task task