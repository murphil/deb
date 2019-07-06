assets:
    tar hzcvf assets.tgz \
        --transform 's|^_\(.*\)|.\1|' \
        -C ${CFG} \
        _zshrc .zshrc.d/