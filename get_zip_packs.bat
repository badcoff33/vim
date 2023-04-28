@setlocal enableextensions & python -x %~f0 %* & goto :EOF
### Python code:

import os
import requests
import zipfile

unpack_to_start = [
        "pack/unzipped/start/",
        "https://github.com/mhinz/vim-signify/archive/refs/heads/master.zip", 
        "https://github.com/godlygeek/tabular/archive/refs/heads/master.zip",
        "https://github.com/aklt/plantuml-syntax/archive/refs/heads/master.zip"
        "https://github.com/preservim/tagbar",
        ]

unpack_to_opt = [
        "pack/unzipped/opt/",
        "https://github.com/junegunn/vim-easy-align/archive/refs/heads/master.zip",
        "https://github.com/lilydjwg/colorizer/archive/refs/heads/master.zip",
        ]

zip_fname = os.getenv("TEMP") + os.sep + "pack_download.zip"
pop_back_dir = os.getcwd()

def unpack_list(list):
    if not os.path.isdir(list[0]):
        os.makedirs(list[0])
    print("for base dir {0}".format(list[0]))
    for url in list[1:]:
        print("get %s" % (url), end = "")
        r = requests.get(url)
        if os.path.isfile(zip_fname):
            os.remove(zip_fname)
        open(zip_fname, 'wb').write(r.content)
        with zipfile.ZipFile(zip_fname, 'r') as zip_ref:
            zip_ref.extractall(list[0])
            print(", unzipped in " + zip_ref.namelist()[0])

unpack_list(unpack_to_start)
unpack_list(unpack_to_opt)

# vim:ft=python:
