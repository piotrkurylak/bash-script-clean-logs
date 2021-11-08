## Bash script: clean_logs.sh

Script which allows you to clean logs older than 3 days.

## Variables
````bash
log_dir="$1"
lock_file_name="$0"
lock_suffix="lock"
lock_file="/tmp/${lock_file_name}_${lock_suffix}"
````

## Functions
````bash
delete_lock_file
create_lock_file
clean_logs
````

