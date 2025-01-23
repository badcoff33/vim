@setlocal enableextensions & python -x %~f0 %* & goto :EOF
### Python code:

# from os import listdir
# from os.path import isfile, join
# onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]

import os
import requests
import zipfile
import glob

# Move all packages to 'opt' dir. Load the packages from user.vim file with ':packadd ...'
unpack_tuple = (
        ("opt", "https://github.com/godlygeek/tabular/archive/refs/heads/master.zip", "tabular"),
        ("opt", "https://github.com/mhinz/vim-signify/archive/refs/heads/master.zip", "signify"),
        ("skip", "https://github.com/preservim/tagbar/archive/refs/heads/master.zip", "tagbar"),
        ("skip", "https://github.com/liuchengxu/vista.vim/archive/refs/heads/master.zip", "vista"),
        ("skip", "https://github.com/junegunn/vim-easy-align/archive/refs/heads/master.zip", "easy-align"),
        ("skip", "https://github.com/justinmk/vim-dirvish/archive/refs/heads/master.zip", "dirvish"),
        ("skip", "https://github.com/aklt/plantuml-syntax/archive/refs/heads/master.zip", ""),
        ("skip", "https://github.com/preservim/vim-wordy/archive/refs/heads/master.zip", ""))

def unpack_list(list):
    zip_fname = os.getenv("TEMP") + os.sep + "pack_download.zip"
    for archive_desc in list:
        pack_dir = archive_desc[0]
        url = archive_desc[1]
        rename_to = archive_desc[2]
        if pack_dir == "skip":
            print("[SKIPPING] %s" % (url), end = "\n")
        else:
            target_dir = "pack/downloads/" + pack_dir
            if not os.path.isdir(target_dir):
                os.makedirs(target_dir)
            print("[DOWNLOAD] %s" % (url), end = "")
            r = requests.get(url)
            open(zip_fname, 'wb').write(r.content)
            z = zipfile.ZipFile(zip_fname, 'r')
            z_root = z.namelist()[0]
            z.extractall(target_dir)
            if rename_to != "":
                print(" unpacked in %s" % (rename_to), end = "\n")
                os.rename(target_dir + os.sep + z_root[:-1], target_dir + os.sep + rename_to)

unpack_list(unpack_tuple)

# vim:ft=python:
