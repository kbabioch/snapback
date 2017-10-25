#! /bin/bash

set -e
#set -x

. ./lib.sh
. ./conf/snapback

#pre_prune() { }
#post_prune() { }

for subvol in $(get_subvols); do

    for snapshot in $(get_snapshots $subvol | egrep -e $(regex_flag "b") | head -n -$KEEP); do

        btrfs subvolume delete "$SNAPDIR/$snapshot" > /dev/null

    done

done

