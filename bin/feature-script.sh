#!/bin/bash

# Function to capitalize the first letter of a string
capitalize_first_letter() {
    string="$1"
    echo "${string^}"
}

# Function to create feature base folder
create_folder() {
    folder_name="$1"
    capitalized_folder_name="$(capitalize_first_letter "$folder_name")"
    mkdir -p "$pathroute/$folder_name/slice"
    mkdir -p "$pathroute/$folder_name/components"
    mkdir -p "$pathroute/$folder_name/services"
    touch "$pathroute/$folder_name/index.ts"
    touch "$pathroute/$folder_name/slice/index.ts"
    touch "$pathroute/$folder_name/components/index.ts"
    touch "$pathroute/$folder_name/services/index.ts"

    # Populate main folder index.ts
    echo "export * from './slice';" > "$pathroute/$folder_name/index.ts"
    echo "export * from './components';" >> "$pathroute/$folder_name/index.ts"
    echo "export * from './services';" >> "$pathroute/$folder_name/index.ts"

    # export folder in index.ts
    echo "export * from './$folder_name';" >> "$pathroute/index.ts"

    # Populate slice folder index.ts
    echo "// Add your slice exports here" > "$pathroute/$folder_name/slice/index.ts"

    # Populate components folder index.ts
    echo "// Add your component exports here" > "$pathroute/$folder_name/components/index.ts"

    # Create and populate Auth hook, service, and type files in the services folder
    touch "$pathroute/$folder_name/services/${capitalized_folder_name}.hook.ts"
    touch "$pathroute/$folder_name/services/${capitalized_folder_name}.service.ts"
    touch "$pathroute/$folder_name/services/${capitalized_folder_name}.type.ts"

    echo "export * from './${capitalized_folder_name}.hook';" > "$pathroute/$folder_name/services/index.ts"
    echo "export * from './${capitalized_folder_name}.service';" >> "$pathroute/$folder_name/services/index.ts"
    echo "export * from './${capitalized_folder_name}.type';" >> "$pathroute/$folder_name/services/index.ts"
    
    # Populate Auth hook with the specified content
    echo "export const ${folder_name}Hook = {" > "$pathroute/$folder_name/services/${capitalized_folder_name}.hook.ts"
    echo "  mutation: {}," >> "$pathroute/$folder_name/services/${capitalized_folder_name}.hook.ts"
    echo "  useQuery: {}," >> "$pathroute/$folder_name/services/${capitalized_folder_name}.hook.ts"
    echo "  prefetch: {}," >> "$pathroute/$folder_name/services/${capitalized_folder_name}.hook.ts"
    echo "};" >> "$pathroute/$folder_name/services/${capitalized_folder_name}.hook.ts"

    #create export for service
    echo "export const ${folder_name}Service = {" > "$pathroute/$folder_name/services/${capitalized_folder_name}.service.ts"
    echo "};" >> "$pathroute/$folder_name/services/${capitalized_folder_name}.service.ts"
    

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
