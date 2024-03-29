#!/bin/bash



apt install gedit 
apt install gnu-stow
apt install trash-cli

#  TODO - setup dotfiles with stow

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Zoxide 
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# add this to end of .bashrc
eval "$(zoxide init bash)"

function ask() {
    read -p "$1 [Y/n] " -r response
    [ -z "$response" ] ||  [ "$response" = "y" ]
}

# TODO - make commands script
# TODO - make aliases script
# TODO - make config script

# TODO - automatically backup commands files etc on startup

for file in ~/shell/* 
do
    fullpath=$(realpath "${file}" )
    if ask "Source ${file}?" ; then
        echo "source ${fullpath}" >> ~/.bashrc
    fi
done

#  TODO - .bash_logout commit and push git for repo changes
git add .
git commit -m "Updated Files"
