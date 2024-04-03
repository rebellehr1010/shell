#!/bin/bash

#!/bin/bash
directories=(
    "/opt/st/stm32cubeide_1.14.0"
    "$HOME/.local/bin"
    "$HOME/.local/share/applications"
    "$HOME/local"
    "$HOME/local/bin"
    "$HOME/local/shell"
    "$HOME/shell"
)

echo "Adding directories to PATH"
# Loop through each directory
for dir in "${directories[@]}"; do
    # Check if directory is already in PATH
    if [[ ":$PATH:" != *":$dir:"* ]]; then
        # Directory is not in PATH, so add it
        export PATH="$dir:$PATH"
        echo "    * Added $dir to PATH"
    fi
done


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
