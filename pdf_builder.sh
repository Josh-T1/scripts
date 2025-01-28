#!bin/bash

# Concatenates pdf documents
# Arg 1: output file name
# Arg 2-n: input pdf file path. Full path or relative path

# Check to ensure command exists and at minimum two arguments passed
command -v gs &>/dev/null && [[ $? == 1 ]] && echo "command 'gs' not found" && exit 1 
(( $# < 2 )) && echo "To few arguments passed" && exit 1

# Prevent writing over existing file
local output_file_name="$1"
[[ -f $output_file_name ]] && echo "$output_file_name already exits" && exit 1

# Validate that all input files exist
shift
for arg in "$@"; do
    [[ ! -f $arg ]] && echo "invalid file path $arg" && exit 1
done

# Combind pdf files
gs -q -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE="$output_file_name" -dBATCH "$@"
# if verbose echo
exit 0
