repos=(https://github.com/plasticboy/vim-markdown.git
           https://github.com/junegunn/vim-easy-align.git \
           https://github.com/liuchengxu/vista.vim.git)
for r in ${repos[*]} ; do {
    s=${r##*/}
    if [ -d Github/start/$s ];
    then {
        pushd Github/start/$s
        git pull
        popd
    };
    else {
        mkdir -p Github/start/$s
        git clone $r Github/start/$s
    };
    fi
}; done
