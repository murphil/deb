##空行(光标在行首)补全 "cd "
user-tab(){
    case $BUFFER in
        "" )                       # 空行填入 "cd "
            BUFFER="cd "
            zle end-of-line
            zle expand-or-complete
            ;;
        " " )
            BUFFER="!?"
            zle end-of-line
            ;;
        "cd --" )                  # "cd --" 替换为 "cd +"
            BUFFER="cd +"
            zle end-of-line
            zle expand-or-complete
            ;;
        "cd +-" )                  # "cd +-" 替换为 "cd -"
            BUFFER="cd -"
            zle end-of-line
            zle expand-or-complete
            ;;
        * )
            zle expand-or-complete
            ;;
    esac
}
zle -N user-tab
bindkey "\t" user-tab

user-ret(){
    if [[ $BUFFER = "" ]] ;then
        BUFFER="ls"
        zle end-of-line
        zle accept-line
    elif [[ $BUFFER = " " ]] ;then
        BUFFER="ls -lh"
        zle end-of-line
        zle accept-line
    elif [[ $BUFFER = "  " ]] ;then
        BUFFER="ls -lah"
        zle end-of-line
        zle accept-line
    elif [[ $BUFFER =~ "\.\.\.+" ]] ;then
        # <1> . 替换为 .. <2> " ../" 替换为 " " <3> // 替换为 /
        BUFFER=${${${BUFFER//\./\.\.\/}// \.\.\// }//\/\//\/}
        zle end-of-line
        zle accept-line
    else
        zle accept-line
    fi
}
zle -N user-ret
bindkey "\r" user-ret

user-spc(){
    # 首字母非空格，以空格结尾 && 光标在行末
    if [[ $LBUFFER =~ "[^~ ]+ $" ]] ;then
        LBUFFER=${LBUFFER}"~"
        zle backward-char
        zle forward-char
        zle expand-or-complete
    else
        zle magic-space
    fi
}
zle -N user-spc
bindkey " " user-spc

user-bspc-word(){
    if [[ $BUFFER = "" ]] ;then
        BUFFER="popd"
        zle accept-line
    else
        zle backward-kill-word
    fi
}
zle -N user-bspc-word
bindkey "\C-w" user-bspc-word

user-bspc(){
    if [[ $BUFFER = "" ]] ;then
        BUFFER="cd .."
        zle accept-line
    else
        zle backward-delete-char
    fi
}
zle -N user-bspc
bindkey "\C-h" user-bspc

user-esc() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    zle end-of-line
}
zle -N user-esc
bindkey "\e\e" user-esc

bindkey "\C-q" push-line-or-edit
bindkey "\C-r" history-incremental-pattern-search-backward
bindkey "\C-s" history-incremental-pattern-search-forward
