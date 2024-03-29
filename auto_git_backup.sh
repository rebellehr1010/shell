#!/bin/bash

function auto_git_backup() {
    echo "Auto commit on logout"
    sleep 20
    git -C "$HOME"/shell add . >> $HOME/shell/log
    git -C "$HOME"/shell commit -m "Auto commit on logout" >> $HOME/shell/log
    git -C "$HOME"/shell push origin main >> $HOME/shell/log
}

auto_git_backup
