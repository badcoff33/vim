@setlocal enableextensions & python -x %~f0 %* & goto :EOF
### Python code:

import os
import requests
import zipfile

gh_dict = {
        "https://github.com/yegappan/lsp/archive/refs/heads/main.zip": "pack/gh/start",
        "https://github.com/mhinz/vim-signify/archive/refs/heads/master.zip": "pack/gh/start", 
        "https://github.com/junegunn/vim-easy-align/archive/refs/heads/master.zip": "pack/gh/opt",
        "https://github.com/justinmk/vim-dirvish/archive/refs/heads/master.zip": "pack/gh/start",
        "https://github.com/lilydjwg/colorizer/archive/refs/heads/master.zip": "pack/gh/opt",
        "https://github.com/liuchengxu/vista.vim/archive/refs/heads/master.zip": "pack/gh/opt",
        }

zip_fname = os.getenv("TEMP") + os.sep + "pack_download.zip"
pop_back_dir = os.getcwd()

for url in gh_dict:
    subdir = gh_dict[url]
    if not os.path.isdir(subdir):
        print("-- creating directory %s" % (subdir))
        os.makedirs(subdir)
    print("-- fetching %s" % (url))
    r = requests.get(url)
    print("-- extract file in %s" % (subdir))
    if os.path.isfile(zip_fname):
        os.remove(zip_fname)
    open(zip_fname, 'wb').write(r.content)
    with zipfile.ZipFile(zip_fname, 'r') as zip_ref:
        zip_ref.extractall(subdir)

# vim:ft=python:
