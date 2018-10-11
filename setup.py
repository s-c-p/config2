#!/usr/bin/python3

import os
import subprocess

_f = ["vim", "git", "fish", "terminator", "lesspass", "firefox", "wallpaper", "fonts"]
# TODO: make _f dict of type feature:{dirs[], urls[], ?paths[()]}
everything = \
{ "features" : _f
, "programs" : _f[0:4]
, "dirs_to_create" : \
    [ "~/.vim/views" , "~/.vim/swaps" , "~/.vim/backups"
    , "~/.vim/autoload" , "~/.vim/plugged" , "~/.vim/colors"
    , "~/.config/git"
    , "~/.local/share/omf", "~/.config/omf", "~/.config/fish"
    , "~/.config/terminator"
    , "~/coding"
    , "~/.mozilla/firefox" , "~/.mozilla/extensions"
    , "~/.fonts"
    ]
}

# utll ----------------

def ris(cmd):
    """ run in shell """
    return subprocess.run(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

dl_file = lambda url: ris("wget " + url)

# workers -----------------

def install_binaries():
    cmd = "sudo apt install -y "
    programs = " ".join(everything["programs"])
    r = ris(cmd + programs)
    if r.stderr:
        ans = input("install failed, [r]etry or [q]uit?\n>>> ")
        if ans in "qQ":
            exit(-1)
    return

def install_lesspass():
    URL = r"https://raw.githubusercontent.com/s-c-p/config2/master/bin/lesspass.py"
    dl_file(URL)

# --------

os.mkdir("temp")

execute(make_selections())

#install_binaries()
#install_lesspass()
