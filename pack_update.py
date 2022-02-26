import os

# access Git repos via hg-git and dulwich.io
vcs_cmd_clone = "hg clone -q"
vcs_cmd_pull = "hg pull -q"

git_dict = {
        "pack/github/start/easy-align": "https://github.com/junegunn/vim-easy-align.git",
        "pack/github/start/colorizer":  "git@github.com:lilydjwg/colorizer.git",
        "pack/github/opt/vista":        "https://github.com/liuchengxu/vista.vim.git",
        "pack/github/opt/signify":      "https://github.com/mhinz/vim-signify.git"}

for subdir in git_dict:
    git_url = git_dict[subdir]
    if not os.path.isdir(subdir):
        print("clone %s" % (git_url))
        os.makedirs(subdir)
        pop_back_dir = os.getcwd()
        os.chdir(subdir)
        os.system(" ".join([vcs_cmd_clone,git_url,"."]))
        os.chdir(pop_back_dir)
    else:
        print( "update %s" % (git_url))
        pop_back_dir = os.getcwd()
        os.chdir(subdir)
        os.system(" ".join([vcs_cmd_pull,git_url,"."]))
        os.chdir(pop_back_dir)


