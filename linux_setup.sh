#!/bin/bash

function ask() {
    read -p "$1 [Y/n] " -r response
    [ -z "$response" ] ||  [ "$response" = "y" ] || [ "$response" = "Y" ]
}

function text_exists_in_file() {
    grep -qF "$1" "$2"
}

function setup_bashrc() {
    local SETUP_FILES_LOCATION="$HOME/shell"
    local SETUP_FILES=("aliases.sh" "config.sh" "path.sh")
    
    for file in "${SETUP_FILES[@]}"; do
        fullpath="${SETUP_FILES_LOCATION}/${file}"
        if [ -e "${fullpath}" ]; then
            if text_exists_in_file "${fullpath}" "$HOME"/.bashrc; then
                echo "${file} is already sourced in .bashrc"
            else 
                if ask "Add source ${file} to .bashrc?" ; then
                    echo "source ${fullpath}" >> "$HOME"/.bashrc
                fi
            fi
        else
            echo "${file} does not exist"
        fi
    done
}

function setup_auto_git_backup() {
    local SHELL_FOLDER_PATH="$HOME/shell"
    if [ -d "$SHELL_FOLDER_PATH" ]; then
        if ask "Setup git for shell folder?" ; then
            if ! text_exists_in_file "auto_git_backup" "$HOME"/.bashrc; then
                echo "trap $SHELL_FOLDER_PATH/auto_git_backup.sh EXIT" >> "$HOME"/.bashrc
            fi
        fi
    fi
}

function apt_installed() {
    dpkg -l "$1" &>/dev/null
}

function install_apt_packages() {
    local APT_PACKAGES=( 
        "gedit"
        "stow"
        "trash-cli"
        "plocate"
        "tldr"
        "snap"
        "restic"
        "rclone"
    )

    # Ask the user if they want to install each SCRIPT_FILE but don't install yet
    for package in "${APT_PACKAGES[@]}"; do
        if apt_installed "${package}"; then
            echo "${package} is already installed"
        else
            if ask "Install ${package}?" ; then
                INSTALL_LIST+=("$package")   
            fi
        fi
    done

    # Install the packages that aren't installed yet
    if [ ${#INSTALL_LIST[@]} -gt 0 ]; then
        sudo apt install "${INSTALL_LIST[@]}" -y
    fi
}

function check_installed() {
    command -v "$1" &> /dev/null 2>&1
}

function install_user_apps() {
    local INSTALLERS_FOLDER="$HOME/shell/installers"

    # Install user SCRIPT_FILEs
    for SCRIPT_FILE in "$INSTALLERS_FOLDER"/*.sh; do
        COMMAND_NAME=$(basename "$SCRIPT_FILE" .sh)

        if check_installed "${COMMAND_NAME}"; then
            echo "${COMMAND_NAME} is already installed"
        else
            if ask "Install ${COMMAND_NAME}?" ; then
                bash "${SCRIPT_FILE}"
            else 
                echo "Skipping ${SCRIPT_FILE}"
            fi
        fi
    done
}

# TODO - download tldr database

source $HOME/.bashrc

setup_bashrc
setup_auto_git_backup
install_user_apps
install_apt_packages
#  TODO - setup dotfiles with stow

# TODO - setup restic and automatically run on trap + schedule
# TODO - setup resticprofile
# https://creativeprojects.github.io/resticprofile/configuration/getting_started/index.html
# TODO - setup rclone to connect to GDrive
# TODO - install firefox

# syncthing-gtk

source $HOME/.bashrc
