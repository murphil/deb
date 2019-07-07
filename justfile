cp:
    rm -rf .zshrc.d .zshrc
    cp -R ${CFG}/_zshrc .zshrc
    cp -R ${CFG}/.zshrc.d .zshrc.d

assets:
    tar hzcvf assets.tgz \
        --transform 's|^_\(.*\)|.\1|' \
        -C ${CFG} \
        _zshrc .zshrc.d/