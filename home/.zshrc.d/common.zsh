alias rm='rm -i'
alias ll='ls -l'
alias mdp='mkdir -p'
alias r='grep --color=auto'
alias diff='diff -u'
alias e='code'
alias g='git'
alias s='ssh'
alias sa='ssh-agent $SHELL'
alias sad='ssh-add'
alias t='tmux'
alias rs="rsync -avP"
alias duh='du -h'
function px { ps aux | grep -i "$*" }
function p { pgrep -a "$*" }
__default_indirect_object="local z=\${@: -1} y=\$1 && [[ \$z == \$1 ]] && y=\"\$default\""

if (( $+commands[just] )) ; then
    export RUNNER=just
fi

if (( $+commands[nvim] )) ; then
    export EDITOR=nvim
    alias v='nvim'
elif (( $+commands[vim] )) ; then
    export EDITOR=vim
    alias v='vim'
else
    export EDITOR=vi
    alias v='vi'
fi

export NOW
currdatetime() {
    NOW=$(date +%y%m%d%H%M%S)
}
autoload -U add-zsh-hook
add-zsh-hook preexec currdatetime