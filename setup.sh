#!/bin/bash

# install binaries
/bin/bash bin/debs-setup.sh

# get lesspass
mkdir ~/coding
cp bin/lesspass.py ~/coding/

# install fonts
mkdir ~/.fonts
tar xf bin/fonts.tar.gz -C ~/.fonts
fc-cache -f -v "~/.fonts"

# configure firefox
mkdir -p ~/.mozilla/{firefox,extensions}
tar xf lib/base.mozilla.tar.gz -C ~/.mozilla/firefox

# configure git
git config --global user.name s-c-p
git config --global user.email prasadsatish45@binkmail.com

# configure vim
mkdir -p ~/.vim/{views,swaps,backups}
cp config/vimrc ~/.vimrc
mkdir -p ~/.vim/autoload
cp config/vim-plug ~/.vim/autoload/plug.vim
mkdir -p ~/.vim/plugged
tar xf lib/vim-plug.tar.gz -C ~/.vim/plugged
mkdir -p ~/.vim/colors
cp config/vim-colorscheme ~/.vim/colors/aristocrat.vim

# configure terminator
mkdir -p ~/.config/terminator
cp config/terminator.config ~/.config/terminator/config

# configure fish
SETUPP="$HOME/.local/share/omf"
CONFIGP="$HOME/.config/omf"
FISHP="$HOME/.config/fish"
mkdir -p $SETUPP
tar xf lib/omf-setup.tar.gz -C $SETUPP
mkdir -p $CONFIGP
mkdir -p $FISHP
# didn't tar these cuz header tar-ing increases size 10x
cp config/shell/omf/* $CONFIGP
cp config/shell/fish/config.fish $FISHP

# change wallpapers
gsettings set org.gnome.desktop.background picture-uri  file:///usr/share/backgrounds/gnome/Road.jpg
gsettings set org.gnome.desktop.screensaver picture-uri file:///usr/share/backgrounds/ubuntu-gnome/pexels-fruit.jpg

# initialized pomodoro sw
/usr/bin/gnome-pomodoro --no-default-window &

# easy git; done at last so that blocking call doesn't interrupt setup
SH="`dirname "$(readlink -f "$0")"`"    # TODO: include this everywhere
mkdir -p "$HOME/.config/git"
openssl enc -d -aes-256-cbc -salt -base64 \
		-in "$SH/config/git-creds" \
		-out "$HOME/.config/git/credentials"
git config --global credential.helper \
		'store --file=/home/ubuntu-gnome/.config/git/credentials'

