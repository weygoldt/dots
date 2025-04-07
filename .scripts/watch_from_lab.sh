 #!/bin/sh

# -------------------------------------------------------------------------
# Continuously pull changes FROM the lab (remote) TO local machine (laptop)
# -------------------------------------------------------------------------
#
# Start an ssh-agent if not already running
# eval "$(ssh-agent -s)"
#
# # Add your key once, enter the passphrase
# ssh-add ~/.ssh/id_ed25519


# User/host and directory paths (same as in your original script):
local_dir="/home/weygoldt/wrk/"
remote_dir="weygoldt@polarbear.am28.uni-tuebingen.de:wrk/"

# How many seconds to wait between each poll:
SLEEP_INTERVAL=2

while true
do
    echo "Checking for changes from remote at $(date)..."
    rsync -avzt --delete "$remote_dir" "$local_dir"
    echo "Sync completed. Sleeping for $SLEEP_INTERVAL seconds..."
    sleep "$SLEEP_INTERVAL"
done

