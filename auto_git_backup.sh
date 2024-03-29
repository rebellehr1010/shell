#!/bin/bash

function auto_git_backup() {
    echo "Auto commit on logout"
    sleep 5
    git -C "$HOME"/shell add .
    git -C "$HOME"/shell commit -m "Auto commit on logout"
    git -C "$HOME"/shell push origin main
}

auto_git_backup
