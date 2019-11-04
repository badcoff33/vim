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
