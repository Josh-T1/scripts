mytest(){
    # Needs re work
    # TODO: write documentation
    local relative_path file_name_no_extension cmd file_arg output
    output="$(_find_package)"
    read -r package_path_formatted package_path <<< "$output"
    current_dir="$(pwd)"
    if [[ -e "$1" ]]; then
        file_name_no_extension="$(basename "$1" .py)"
        output="$(_find_package)"
        relative_path="$package_path_formatted.$file_name_no_extension"
    #    (( "$#" == 2 )) && [[ "$2" == "-v" || "$2" == "--verbose" ]] && echo "running command 'python3 -m $relative_path' in dir '$package_path'" We would need to determine a method for determnig arguments
        cmd="python3 -m unittest $relative_path"
    else
        cmd="python3 -m unittest $@"
    fi

    cd "$package_path"
    eval "$cmd" || cd "$current_dir"
    cd "$current_dir"
}
