 #!/bin/sh

local_dir="/home/weygoldt/wrk/"
remote_dir_1="localadmin@torpedo.am28.uni-tuebingen.de:/cerebrum/weygoldt/"
remote_dir_2="/mnt/data2/weygoldt_backup/"

echo "Syncing to torpedo..."
rsync -avzt --delete --exclude '*/.venv/*' $local_dir $remote_dir_1

echo "Syncing to data2..."
rsync -avzt --delete --exclude '*/.venv/*' $local_dir $remote_dir_2
