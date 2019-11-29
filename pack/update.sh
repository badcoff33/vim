if [ -d Github/start/ctrlp ]; 
then {
  pushd Github/start/ctrlp
  git pull
  popd
};
else {
  mkdir -p Github/start/ctrlp
  git clone https://github.com/ctrlpvim/ctrlp.vim.git Github/start/ctrlp
};
fi

if [ -d Github/start/easy-align ]; 
then {
  pushd Github/start/easy-align
  git pull
  popd
};
else {
  mkdir -p Github/start/easy-align
  git clone https://github.com/junegunn/vim-easy-align.git Github/start/easy-align
};
fi

if [ -d Github/start/tagbar ]; 
then {
  pushd Github/start/tagbar
  git pull
  popd
};
else {
  mkdir -p Github/start/tagbar
  git clone https://github.com/majutsushi/tagbar.git  Github/start/tagbar
};
fi
