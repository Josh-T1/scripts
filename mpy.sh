#!/bin/bash

# Automates the process of running a python file at the module level by performing the required changes in directory before running
# the command `python -m {file}.py {arg1} {arg2}...`

# The project root must contain .mpy file
# Note: We set a max depth, if the project depth exceeds max depth
# the command will fail

# Arg 1: relative path to python file
# Arg 2-n: arguments for python file

source project_utils.sh
current_dir="$(pwd)"
# parse out file name, pretty sure I can use a one liner instead...
while [[ $# -gt 0 ]]; do
    case $1 in
        *.py)
            local file_arg="$1"
            shift
            break
            ;;
        *)
            echo "Invalid flag $1" && exit 1
    esac
done
# Account for relative paths
if [[ $file_arg == */* ]]; then
    local relative_move="${file_arg%/*}" 
    [[ -n $relative_move ]] && cd "$relative_move" && echo "$relative_move"
fi


local file_name_no_extension="$(basename "$file_arg" .py)"
local output="$(_find_package)"

read -r package_path_formatted package_path <<< "$output"

relative_path="$package_path_formatted.$file_name_no_extension"

cd "$package_path"
python3 -m "$relative_path" "$@" || cd "$current_dir" && exit 1
cd "$current_dir"
exit 0


