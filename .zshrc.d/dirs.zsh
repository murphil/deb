if [[ -d $HOME/world ]]; then
    hash -d w="$HOME/world"
else
    hash -d w="/world"
fi

hash -d h="$WHEEL"
hash -d s="$HOME/.ssh"
hash -d p="$HOME/pub"
hash -d d="$HOME/Downloads"
hash -d tut="$HOME/pub/Tutorial"
hash -d cfg="$CFG"
hash -d doc="$HOME/Documents"