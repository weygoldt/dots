 #!/bin/sh

# Define source and destination directories
local_dir="/home/weygoldt/wrk/"
remote_dir="weygoldt@polarbear.am28.uni-tuebingen.de:wrk/"

# Check if argument is provided
if [ "$1" == "tolab" ]; then
    source_dir="$local_dir"
    destination_dir="$remote_dir"
    direction="to the lab"
elif [ "$1" == "fromlab" ]; then
    source_dir="$remote_dir"
    destination_dir="$local_dir"
    direction="from the lab"
else
    echo "Usage: $0 [tolab | fromlab]"
    exit 1
fi

# Perform a dry-run preview of changes
echo "Preview of changes:"
rsync -avzt --delete --dry-run $source_dir $destination_dir

# Ask user for confirmation
read -p "Do you want to sync these changes? (yes/no): " answer

# Check user's response
if [[ $answer =~ ^[Yy][Ee][Ss]$ ]]; then
    echo "Syncing directories..."
    # Perform sync without dry-run
    rsync -avzt --delete "$source_dir" "$destination_dir"
    echo "Sync completed."
elif [[ $answer =~ ^[Nn][Oo]$ ]]; then
    echo "Sync operation declined. Exiting."
else
    echo "Invalid response. Exiting."
fi
