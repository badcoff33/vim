@setlocal enableextensions & python -x %~f0 %* & goto :EOF
### Python code:
import os

# access Git repos via hg-git and dulwich.io
vcs_cmd_clone = "hg clone -q"
vcs_cmd_pull = "hg pull -q"

git_dict = {
        "pack/gh/start/signify":     "git@github.com:mhinz/vim-signify.git",
        "pack/gh/start/dirvish":     "git@github.com:justinmk/vim-dirvish.git",
        "pack/gh/start/easy-align":  "git@github.com:junegunn/vim-easy-align.git",
        "pack/gh/start/fzf.git":     "git@github.com:junegunn/fzf.git",
        "pack/gh/start/fzf.vim":     "git@github.com:junegunn/fzf.vim.git",
        "pack/gh/opt/colorizer":     "git@github.com:lilydjwg/colorizer.git",
        "pack/gh/opt/vista":         "git@github.com:liuchengxu/vista.vim.git",
        "pack/gh/opt/wordy":         "git@github.com:preservim/vim-wordy.git" }

for subdir in git_dict:
    git_url = git_dict[subdir]
    if not os.path.isdir(subdir):
        print("clone %s to %s" % (git_url, subdir))
        os.makedirs(subdir)
        pop_back_dir = os.getcwd()
        os.chdir(subdir)
        os.system(" ".join([vcs_cmd_clone,git_url,"."]))
        os.chdir(pop_back_dir)
    else:
        print("update %s in %s" % (git_url, subdir))
        pop_back_dir = os.getcwd()
        os.chdir(subdir)
        os.system(" ".join([vcs_cmd_pull,git_url,"."]))
        os.chdir(pop_back_dir)

# vim:ft=python:
