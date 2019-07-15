#!/usr/bin/env zsh

#-------------------------------------------------------------------------------
# configuration, the base under which the directory histories are stored
#-------------------------------------------------------------------------------

[[ -z $HISTORY_BASE ]] && HISTORY_BASE="$HOME/.directory_history"
[[ -z $PER_DIRECTORY_HISTORY_TOGGLE ]] && PER_DIRECTORY_HISTORY_TOGGLE='^G'

#-------------------------------------------------------------------------------
# toggle global/directory history used for searching - ctrl-G by default
#-------------------------------------------------------------------------------

function per-directory-history-toggle-history() {
  if [[ $_per_directory_history_is_global == true ]]; then
    _per-directory-history-set-directory-history
    print -n "\nusing local history"
  else
    _per-directory-history-set-global-history
    print -n "\nusing global history"
  fi
  zle .push-line
  zle .accept-line
}

autoload per-directory-history-toggle-history
zle -N per-directory-history-toggle-history
bindkey $PER_DIRECTORY_HISTORY_TOGGLE per-directory-history-toggle-history

#-------------------------------------------------------------------------------
# implementation details
#-------------------------------------------------------------------------------

_per_directory_history_directory="$HISTORY_BASE${PWD:A}/history"

function _per-directory-history-change-directory() {
  _per_directory_history_directory="$HISTORY_BASE${PWD:A}/history"
  mkdir -p ${_per_directory_history_directory:h}
  if [[ $_per_directory_history_is_global == false ]]; then
    #save to the global history
    fc -AI $HISTFILE
    #save history to previous file
    local prev="$HISTORY_BASE${OLDPWD:A}/history"
    mkdir -p ${prev:h}
    fc -AI $prev

    #discard previous directory's history
    local original_histsize=$HISTSIZE
    HISTSIZE=0
    HISTSIZE=$original_histsize

    #read history in new file
    if [[ -e $_per_directory_history_directory ]]; then
      fc -R $_per_directory_history_directory
    fi
  fi
}

function _per-directory-history-addhistory() {
  # respect hist_ignore_space
  if [[ -o hist_ignore_space ]] && [[ "$1" == \ * ]]; then
      true
  else
      print -Sr -- "${1%%$'\n'}"
      fc -p $_per_directory_history_directory
  fi
}


function _per-directory-history-set-directory-history() {
  if [[ $_per_directory_history_is_global == true ]]; then
    fc -AI $HISTFILE
    local original_histsize=$HISTSIZE
    HISTSIZE=0
    HISTSIZE=$original_histsize
    if [[ -e "$_per_directory_history_directory" ]]; then
      fc -R "$_per_directory_history_directory"
    fi
  fi
  _per_directory_history_is_global=false
}
function _per-directory-history-set-global-history() {
  if [[ $_per_directory_history_is_global == false ]]; then
    fc -AI $_per_directory_history_directory
    local original_histsize=$HISTSIZE
    HISTSIZE=0
    HISTSIZE=$original_histsize
    if [[ -e "$HISTFILE" ]]; then
      fc -R "$HISTFILE"
    fi
  fi
  _per_directory_history_is_global=true
}


#add functions to the exec list for chpwd and zshaddhistory
autoload -U add-zsh-hook
add-zsh-hook chpwd _per-directory-history-change-directory
add-zsh-hook zshaddhistory _per-directory-history-addhistory

#start in directory mode
mkdir -p ${_per_directory_history_directory:h}
_per_directory_history_is_global=true
_per-directory-history-set-directory-history