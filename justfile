cp cfg="~/pub/Configuration":
    rm -rf home
    mkdir home
    cp -R {{cfg}}/_zshrc home/.zshrc
    cp -R {{cfg}}/.zshrc.d home/.zshrc.d
    cp -R {{cfg}}/_vimrc home/.vimrc
    cp -R {{cfg}}/_tmux.conf home/.tmux.conf

assets:
    tar hzcvf assets.tgz \
        --transform 's|^_\(.*\)|.\1|' \
        -C ${CFG} \
        _zshrc .zshrc.d/ _vimrc.d

test:
    docker build . -t tt -f Dockerfile-test
