cp cfg="~/pub/Configuration":
    rm -rf .zshrc.d .zshrc
    cp -R {{cfg}}/_zshrc .zshrc
    cp -R {{cfg}}/.zshrc.d .zshrc.d
    cp -R {{cfg}}/_vimrc .vimrc
    cp -R {{cfg}}/_tmux.conf .tmux.conf

assets:
    tar hzcvf assets.tgz \
        --transform 's|^_\(.*\)|.\1|' \
        -C ${CFG} \
        _zshrc .zshrc.d/ _vimrc.d
