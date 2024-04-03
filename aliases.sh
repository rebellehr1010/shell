#!/bin/bash

# Define the aliases
aliases=(
    "cubemx=/usr/local/STMicroelectronics/STM32Cube/STM32CubeMX/STM32CubeMX"
    "cubeprogrammer=/usr/local/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin/STM32CubeProgrammer"
    "cubeprogrammercli=/usr/local/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin/STM32_Programmer_CLI"
    "sudo=sudo "
    "mv=mv -i "
    "cp=cp -i "
    "rm=rm -i "
    "find=find / -mount "
    "resource=source ~/.bashrc"
)
echo ""
echo "Creating Aliases"
# Loop through each alias
for alias_cmd in "${aliases[@]}"; do
    # Split the alias and its command
    IFS="=" read -r alias_name alias_command <<< "$alias_cmd"

    # Check if alias already exists
    existing_alias=$(alias "$alias_name" 2>/dev/null)
    if [[ -z "$existing_alias" ]]; then
        # Create the alias
        alias "$alias_name"="$alias_command"
        echo "    * Alias created: $alias_name -> $alias_command"
    fi
done
