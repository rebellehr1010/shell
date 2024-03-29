#!/bin/bash

# Function to add paths to the PATH variable
add_to_path() {
    local path
    for path in "$@"; do
        # Check if the path exists and is a directory
        if [ -d "$path" ]; then
            # Append the path to the PATH variable if not already present
            if [[ ":$PATH:" != *":$path:"* ]]; then
                export PATH="$PATH:$path"
                echo "Added $path to PATH"
            else
                echo "$path is already in PATH"
            fi
        else
            echo "$path is not a valid directory"
        fi
    done
}

# Hardcoded paths
paths=(
    "$HOME/.local/bin"
    "$HOME/shell"
)

# Add paths to the PATH variable
add_to_path "${paths[@]}"
