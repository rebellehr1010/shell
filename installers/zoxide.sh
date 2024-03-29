#!/bin/bash

curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash 
echo 'eval "$(zoxide init --cmd cd bash)"' >> ~/.bashrc

# Check if $HOME/.local/bin is already in $PATH
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    # Add $HOME/.local/bin to $PATH
    echo "export PATH=""$HOME"/.local/bin:"$PATH""" >> ~/.bashrc
    # Update current session's $PATH
    export PATH=$PATH:$HOME/.local/bin
else 
    echo "$HOME/.local/bin is already in PATH"
fi
