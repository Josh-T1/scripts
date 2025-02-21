#!/bin/bash

# Finds python library root and sources corresponding Venv

# In order to use this your project must have the following structure
#   1. empty .mpy_root file at library root
#   2. Say the python library is called "Scripts" located at "{path to Scripts}/Scripts". There must be a virtual environment
#      named "Scripts" under "$HOME/venvs/"


# If cwd is within a python package, search for the corresponding venv -- sourcing `venv/bin/activate`, it if it exists
SCRIPT_DIR="$HOME/Code/Scripts"
source "$SCRIPT_DIR/project_utils.sh"
output="$(find_package)"
[[ $? -eq 1 ]] && echo "Could not find package" && exit 1

read -r package_path_formatted package_path <<< "$output"
package_name="${package_path_formatted%%.*}"
activate_path="$HOME/venvs/$package_name/bin/activate"
[[ ! -e $activate_path ]] && echo "Venv $activate_path does not exist" && exit 1
echo "$activate_path"
exit 0
