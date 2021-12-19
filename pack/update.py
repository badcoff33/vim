import os

vcs_cmd_clone = "hg clone -q"
vcs_cmd_pull = "hg pull -q"

git_dict = { 
        "github/start/easy-align": "https://github.com/junegunn/vim-easy-align.git",
        "github/opt/vista":        "https://github.com/liuchengxu/vista.vim.git",
        "github/opt/gitgutter":    "https://github.com/airblade/vim-gitgutter",
        "github/opt/dirvish":      "https://github.com/justinmk/vim-dirvish.git" }

for subdir in git_dict:
    git_url = git_dict[subdir]
    if not os.path.isdir(subdir):
        print("clone %s" % (git_url))
        os.makedirs(subdir)
        os.system(" ".join([vcs_cmd_clone,git_url,subdir]))
    else:
        print( "update %s" % (git_url))
        os.makedirs(subdir)        
        os.system(" ".join([vcs_cmd_clone,git_url,subdir]))


