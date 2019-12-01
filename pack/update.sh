repos=(https://github.com/ctrlpvim/ctrlp.vim.git \
           https://github.com/junegunn/vim-easy-align.git \
           https://github.com/majutsushi/tagbar.git)
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
