#!/bin/bash

# TODO - check rclone installed and configured

# add to .bashrc
# RESTIC_REPOSITORY="remote:linux_backup"
# RESTIC_PASSWORD="oceLot14!"

curl -LO https://raw.githubusercontent.com/creativeprojects/resticprofile/master/install.sh
chmod +x install.sh
sudo ./install.sh -b /usr/local/bin

# symlink profiles.conf to home/rebellehr
CONFIG_FILE_DIRECTORY="$HOME/.config/resticprofile"

mkdir -p "$CONFIG_FILE_DIRECTORY"
ln -s "$HOME"/shell/profiles.toml "$HOME/.config/resticprofile/profiles.toml"