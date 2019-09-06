ZSHRC=${(%):-%N}

if [[ $(uname -sm) = Darwin\ * ]]; then
    alias readlink="greadlink"
fi

CFG=${$(readlink -f $ZSHRC)%/*}

() {
    local i
    for i in $CFG/.zshrc.d/[^_]*.zsh; do
        source $i
    done
}

if [[ ! "$PATH" == *${HOME}/.local/bin* ]]; then
    export PATH=${HOME}/.local/bin:$PATH
fi

[ -f $CFG/.ext.zsh ] && source $CFG/.ext.zsh
