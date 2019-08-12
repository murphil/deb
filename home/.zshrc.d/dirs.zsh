if [[ -d $HOME/world ]]; then
    hash -d w="$HOME/world"
else
    hash -d w="/world"
fi

hash -d c="$CFG"
hash -d h="$WHEEL"
hash -d s="$HOME/.ssh"
hash -d p="$HOME/pub"
hash -d d="$HOME/Downloads"
hash -d doc="$HOME/Documents"
hash -d tut="$HOME/pub/Tutorial"
hash -d plt="$HOME/pub/Platform"
