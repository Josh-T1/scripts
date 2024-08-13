#!bin/bash
# Once per shell session the local ip must be set. 
# Target dir must be set everytime you move directories
# We default to target dir on machine being equal to location where file's exist
#
local local_ip machine_name transfer_root_dir

# Get 'session' variables from user if not set
if [[ -z $MY_MACHINE_NAME ]]; then
    read -p "Enter machine name: " machine_name
fi

if [[ -z $MY_DOMAIN_NAME ]]; then
    read -p "Enter local network ip of machine: " local_ip
fi


# Set 'session' variables
if [[ -z "$local_ip" ]]; then
    echo "local ip can not be empty" && exit 1
else
    export MY_DOMAIN_NAME="$local_ip"
fi

if [[ -z "$machine_name" ]]; then
    echo "Machine name can not be empty" && exit 1
else
    export MY_MACHINE_NAME="$local_ip"
fi



has_file(){
    local dir="$1"
    ssh $MY_MACHINE_NAME@MY_DOMAIN_NAME "test -e \"$dir\" && echo 'exists'"
}

copy_files(){
    local target_dir="$1"
    local my_dir="$2"
    local file_name="$3"

    local file filename exists

    while [[ $# -gt 0 ]]; do
        exists="$(has_file "$target_dir/$file_name")"

        if [[ "$exists" != "exists" ]]; then
            if [[ -d "$my_dir/$file_name" ]]; then
                rsync -a -r --exclude="__pycache__" source/ "$my_dir/$file_name" "$MY_MACHINE_NAME@$MY_DOMAIN_NAME:$target_dir/$file_name"
                echo "Added dir $file"

            else
                rsync -a --exclude="__pycache__" source/ "$my_dir/$file_name" "$MY_MACHINE_NAME@$MY_DOMAIN_NAME:$target_dir/$file_name"
                echo "added file $file"
            fi
        fi
                
    done 
}



local target_dir
local my_dir
read -p "Enter dir to be copied from: " $my_dir
read -p "Enter dir to be moved to: " $target_dir
[[ ! -d $my_dir ]] && echo "Not a directory $my_dir" && exit 1
target_dir_exists=$(ssh $MY_MACHINE_NAME@MY_DOMAIN_NAME "test -d \"$target_dir\" && echo 'exists'")
[[ -z "$target_dir" ]] && echo "Not a directory $target_dir" && exit 1
copy_files "$target_dir" "$my_dir" $@
echo ""
echo "*** DONE *** "
