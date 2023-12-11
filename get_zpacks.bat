@setlocal enableextensions & python -x %~f0 %* & goto :EOF
### Python code:

import os
import requests
import zipfile
import glob

unpack_tuple = (
        ("start", "https://github.com/axvr/org.vim/archive/refs/heads/master.zip"),
        ("start", "https://github.com/mhinz/vim-signify/archive/refs/heads/master.zip"),
        ("start", "https://github.com/Donaldttt/fuzzyy/archive/refs/heads/vim9.zip"),
        ("start", "https://github.com/junegunn/vim-easy-align/archive/refs/heads/master.zip"),
        ("start", "https://github.com/preservim/tagbar/archive/refs/heads/master.zip"),
        ("opt",   "https://github.com/aklt/plantuml-syntax/archive/refs/heads/master.zip"),
        ("opt",   "https://github.com/lilydjwg/colorizer/archive/refs/heads/master.zip"),
        ("opt",   "https://github.com/preservim/vim-wordy/archive/refs/heads/master.zip"),
        ("opt",   "https://github.com/justinmk/vim-dirvish/archive/refs/heads/master.zip"),
        ("skip",  "https://github.com/dhruvasagar/vim-table-mode/archive/refs/heads/master.zip"),
        ("skip",  "https://github.com/godlygeek/tabular/archive/refs/heads/master.zip"))

zip_fname = os.getenv("TEMP") + os.sep + "pack_download.zip"
pop_back_dir = os.getcwd()

def unpack_list(list):
    for archive_desc in list:
        url = archive_desc[1]
        print("-- %s ... " % (url), end = "")
        if archive_desc[0] == "skip":
            print("skipping")
        else:
            target_dir = "pack/zpacks/" + archive_desc[0]
            if not os.path.isdir(target_dir):
                os.makedirs(target_dir)
            print("downloading", end = "")
            r = requests.get(url)
            open(zip_fname, 'wb').write(r.content)
            with zipfile.ZipFile(zip_fname, 'r') as zip_ref:
                zip_ref.extractall(target_dir)
            print(",unzipped")

unpack_list(unpack_tuple)

# vim:ft=python:
