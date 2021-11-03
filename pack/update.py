import os

github_home_dir = "Github/start/"
git_dict = { "easy-align": "https://github.com/junegunn/vim-easy-align.git",
        "signify": "https://github.com/mhinz/vim-signify.git",
        "dirvish": "https://github.com/justinmk/vim-dirvish.git"}

saved_pwd = os.getcwd()
os.chdir( github_home_dir )
for subdir in git_dict:
    git_url = git_dict[ subdir ]
    if not os.path.isdir( subdir ):
        print( "clone %s" % ( git_url ) )
        os.makedirs( subdir )
        os.system( "hg clone " + git_url + " " + subdir )
    else:
        print( "update %s" % ( git_url ) )
        os.chdir( subdir )
        os.system( "hg clone " + git_url )
        os.chdir( ".." )

os.chdir( saved_pwd )

