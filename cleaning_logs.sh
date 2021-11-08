#!/bin/bash
#
#
## Clean logs older than 3 days.


## In case of any error and unused variable exit immediately.
set -eu

## Variables
log_dir="$1"
lock_file="/tmp/$0_lock_file"

## Find files older than 3 days.
files=(find . -name "*.log" -type f -mtime +3)

## Function for deleting lock file.
function delete_lock_file() {
    if [[ -e "$lock_file" ]]; then
    rm -f "${lock_file}" || {
        printf "Cannot delete lock file\n" >&2;
        exit 4
    }
    fi
}

## Function for creating lock file.
function create_lock_file() {
    touch "${lock_file}" || {
        printf "Cannot create lock file, exiting.\n" >&2;
        exit 2
}
}

## Check if lock_file exists, maybe another instance of script is running.
if [[ -e "${lock_file}" ]]; then
printf "Found lock file, another instance of script is running?\n" >&2;
exit 1
fi

## Execute function which creates lock file.
create_lock_file

## Go to logs directory.
cd "${log_dir}" || {
    delete_lock_file
    printf "Cannot enter logs directory.\n" >&2;
    exit 3
}

## Delete files listed by find command.
for file in "${files[@]}"
do
rm -f $( "${files[@]}" ) || {
    printf "Cannot delete %s.\n" "${file}" >&2;
    exit 5
}
done

## Only for testing lock file.
sleep 5

delete_lock_file
printf "Exit code: %d\n" "${?}" 

