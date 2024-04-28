#!/bin/bash

# Function to create feature base folder
create_folder() {
    folder_name="$1"
    mkdir -p "$pathroute/$folder_name/slice"
    mkdir -p "$pathroute/$folder_name/components"
    mkdir -p "$pathroute/$folder_name/services"
    mkdir -p "$pathroute/$folder_name/store"
    touch "$pathroute/$folder_name/index.ts"
    touch "$pathroute/$folder_name/slice/index.ts"
    touch "$pathroute/$folder_name/components/index.ts"
    touch "$pathroute/$folder_name/services/index.ts"
    touch "$pathroute/$folder_name/store/index.ts"

    # Populate main folder index.ts
    echo "export * from './slice';" > "$pathroute/$folder_name/index.ts"
    echo "export * from './components';" >> "$pathroute/$folder_name/index.ts"
    echo "export * from './services';" >> "$pathroute/$folder_name/index.ts"
    echo "export * from './store';" >> "$pathroute/$folder_name/index.ts"

    # export folder in index.ts
    echo "export * from './$folder_name';" >> "$pathroute/index.ts"

    # Populate slice folder index.ts
    echo "// Add your slice exports here" > "$pathroute/$folder_name/slice/index.ts"

    # Populate components folder index.ts
    echo "// Add your component exports here" > "$pathroute/$folder_name/components/index.ts"

    echo "Folder '$folder_name' created and exported successfully!"
}

# Default value for pathroute
default_pathroute="./apps/pwa/src/features"

# Check if folder name is provided as command-line argument
if [ -z "$1" ]; then
    # Prompt the user for folder name
    read -p "Enter features base folder name: " folder_name
else
    folder_name="$1"
fi

# Prompt the user for pathroute
read -p "Enter path route for the folder [Default: $default_pathroute]: " pathroute_input

# If pathroute is not provided, use the default value
if [ -z "$pathroute_input" ]; then
    pathroute=$default_pathroute
else
    pathroute=$pathroute_input
fi

# Check if folder name is provided
if [ -z "$folder_name" ]; then
    echo "Please provide a folder name."
    exit 1
fi

# Call the function to create the folder
create_folder "$folder_name"
