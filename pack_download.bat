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
        ("opt", "https://github.com/mhinz/vim-signify/archive/refs/heads/master.zip", "signify"),
        ("opt", "https://github.com/junegunn/vim-easy-align/archive/refs/heads/master.zip", "easy-align"),
        ("opt", "https://github.com/preservim/tagbar/archive/refs/heads/master.zip", "tagbar"),
        ("opt", "https://github.com/justinmk/vim-dirvish/archive/refs/heads/master.zip", "dirvish"),
        ("opt", "https://github.com/dhruvasagar/vim-table-mode/archive/refs/heads/master.zip", "table-mode"),
        ("opt", "https://github.com/godlygeek/tabular/archive/refs/heads/master.zip", "tabular"),
        ("opt", "https://github.com/jceb/vim-orgmode/archive/refs/heads/master.zip", "orgmode"),
        ("skip", "https://github.com/Donaldttt/fuzzyy/archive/refs/heads/vim9.zip", ""),
        ("skip", "https://github.com/aklt/plantuml-syntax/archive/refs/heads/master.zip", ""),
        ("skip", "https://github.com/preservim/vim-wordy/archive/refs/heads/master.zip", ""))

zip_fname = os.getenv("TEMP") + os.sep + "pack_download.zip"
pop_back_dir = os.getcwd()

def unpack_list(list):
    for archive_desc in list:
        url = archive_desc[1]
        rename_to = archive_desc[2]
        print("-- %s ... " % (url), end = "")
        if archive_desc[0] == "skip":
            print("skipping")
        else:
            target_dir = "pack/downloads/" + archive_desc[0]
            if not os.path.isdir(target_dir):
                os.makedirs(target_dir)
            print("downloading", end = "")
            r = requests.get(url)
            open(zip_fname, 'wb').write(r.content)
            z = zipfile.ZipFile(zip_fname, 'r')
            z_root = z.namelist()[0]
            z.extractall(target_dir)
            if rename_to != "":
                print(",unzipped,renamed")
                os.rename(target_dir + os.sep + z_root[:-1], target_dir + os.sep + rename_to)
            else:
                print(",unzipped")


unpack_list(unpack_tuple)

# vim:ft=python:
