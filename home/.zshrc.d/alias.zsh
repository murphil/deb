alias rm='rm -i'
alias ll='ls -l'
alias mdp='mkdir -p'
alias grep='grep --color=auto'
alias diff='diff -u'
alias e='nvim'
alias v='nvim'
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