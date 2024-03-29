#!/bin/bash

function ask() {
    read -p "$1 [Y/n] " -r response
    [ -z "$response" ] ||  [ "$response" = "y" ] || [ "$response" = "Y" ]
}

function text_exists_in_file() {
    grep -qF "$1" "$2"
}

function add_to_path() {
    local PATHS_TO_ADD=(
        "$HOME/shell"
    )

    for path in "${PATHS_TO_ADD[@]}"; do
        if ! text_exists_in_file "$path" "$HOME"/.bashrc; then
            echo "export PATH=$path:$PATH" >> "$HOME"/.bashrc
            export PATH=$path:$PATH
        else
            echo "$path is already in PATH"
        fi
    done
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
    local AUTO_GIT_COMMAND="git -C $SHELL_FOLDER_PATH add .
git -C $SHELL_FOLDER_PATH commit -m \"Auto commit on logout\"
git -C $SHELL_FOLDER_PATH push origin main"
    if text_exists_in_file "${AUTO_GIT_COMMAND}" "$HOME"/.bash_logout; then
            echo "Auto git backup is already setup"
    else
        if ask "Setup git for shell folder?" ; then
            echo "${AUTO_GIT_COMMAND}" >> "$HOME"/.bash_logout
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

source $HOME/.bashrc

setup_bashrc
setup_auto_git_backup
install_user_apps
install_apt_packages
#  TODO - setup dotfiles with stow

source $HOME/.bashrc
