
is_project_root(){
    # Check if the directory contains .mpy_root
    # Arg 1: directory path
    local dir="$1"
    local file_name="$dir/.mpy_root"
    if [[ -f  $file_name ]]; then 
        return 0
    else
        return 1
    fi
}


find_package(){
    # Optional Arg: max traverse depth
    # Returns (cwd package name, full package path) if cwd is inside a python package
    local full_dir_name="$(pwd)"
    local dir_name="$(basename "$full_dir_name")"
    local formatted_path=""
    local max_depth="${1:-7}" # arg 1, if arg 1 is non emtpy, otherwise 7
    local depth=0
     
    while (( depth < max_depth )); do

        if [[ "$full_dir_name" == "$HOME" ]]; then
            exit 1
        fi

        is_root=$(is_project_root "$full_dir_name")


        if [[ -z "$formatted_path" ]]; then 
            formatted_path="$dir_name"
        else
            formatted_path="$dir_name.$formatted_path"
        fi

        full_dir_name="$(dirname "$full_dir_name")"
        dir_name="$(basename "$full_dir_name")"

        if (( is_root == 0 )); then
            break
        fi

        (( depth++ ))
        if [[ $depth == $max_depth ]]; then 
            exit 1
        fi
    
    done
    echo "$formatted_path $full_dir_name"
}

