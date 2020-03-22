import os

git_dict = { "easy-align": "https://github.com/junegunn/vim-easy-align.git",
        "vista": "https://github.com/liuchengxu/vista.vim.git",
        "LangClient": "https://github.com/autozimu/LanguageClient-neovim.git",
        "dirvish": "https://github.com/justinmk/vim-dirvish.git" }
github_home_dir = "Github/start/"

saved_pwd = os.getcwd()
os.chdir( github_home_dir )
for subdir in git_dict:
    print(subdir)
    git_url = git_dict[ subdir ]
    if not os.path.isdir( subdir ):
        os.makedirs( subdir )
        os.system( "git clone " + git_url + " " + subdir )
    else:
        os.chdir( subdir )
        os.system( "git pull " + git_url )
        os.chdir( ".." )


os.chdir( saved_pwd )

#   echo "tail is :" %~nR
# )
# ::    s=${r##*/}
# ::    if [ -d Github/start/$s ];
# ::    then {
# ::        pushd Github/start/$s
# ::        git pull
# ::        popd
# ::    };
# ::    else {
# ::        mkdir -p Github/start/$s
# ::        git clone $r Github/start/$s
# ::    };
# ::    fi
# ::}; done
