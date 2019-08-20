alias rm='rm -i'
alias ll='ls -l'
alias mdp='mkdir -p'
alias r='grep --color=auto'
alias diff='diff -u'
alias v='nvim'
alias e='code'
alias g='git'
alias m='make'
alias s='ssh'
alias sa='ssh-agent $SHELL'
alias sad='ssh-add'
alias t='tmux'
alias rs="rsync -avP"
alias duh='du -h'
function px { ps aux | grep -i "$*" }
function p { pgrep -a "$*" }
__default_indirect_object="local z=\${@: -1} y=\$1 && [[ \$z == \$1 ]] && y=\"\$default\""

export NOW
currdatetime() {
    NOW=$(date +%y%m%d%H%M%S)
}
autoload -U add-zsh-hook
add-zsh-hook preexec currdatetime