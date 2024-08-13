#!bin/bash

# Helper functions
check_dir_exists_then_make(){
    local dir_full_path="$1"
    local parent_path=$(dirname "$dir_full_path")
    if [[ ! -d "$dir_full_path" ]] && [[ -d "$parent_path" ]]; then
        mkdir "$dir_full_path"
        echo "Made dir: $dir_full_path"
    elif [[ ! -d "$parent_path" ]]; then
        echo "Parent dir: $parent_path does not exist. Skiping creation of $dir_full_path"
    else
        echo "Dir $dir_full_path already exists. Skipping creation"
    fi
}
check_file_exsits_then_touch(){}
cd "$HOME"


# Build directories
check_exists_then_make "$HOME/Code"
check_exists_then_make "$HOME/Code/Script"

# Build python related dirs
check_exists_then_make "$HOME/Code/python"
check_exists_then_make "$HOME/Code/python/MyProjects"

# Scripts
check_exists_then_make "$HOME/Code/Scripts"
# Nvim config
check_exists_then_make "$HOME/.config/nvim"
check_exists_then_make "$HOME/.config/nvim/ftplugin"
check_exists_then_make "$HOME/.config/nvim/Lua"
check_exists_then_make "$HOME/.config/nvim/Lua"

mkdir "$HOME/Code"

