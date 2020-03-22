import os

git_dict = { "easy-align": "https://github.com/junegunn/vim-easy-align.git",
        "vista": "https://github.com/liuchengxu/vista.vim.git",
        "LangClient": "https://github.com/autozimu/LanguageClient-neovim.git",
        "dirvish": "https://github.com/justinmk/vim-dirvish.git" }
github_home_dir = "Github/start/"

saved_pwd = os.getcwd()
os.chdir( github_home_dir )
for subdir in git_dict:
    git_url = git_dict[ subdir ]
    if not os.path.isdir( subdir ):
        print( "clone %s" % ( git_url ) )
        os.makedirs( subdir )
        os.system( "git clone -q " + git_url + " " + subdir )
    else:
        print( "update %s" % ( git_url ) )
        os.chdir( subdir )
        os.system( "git pull -q " + git_url )
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
