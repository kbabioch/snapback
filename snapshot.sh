#! /bin/bash

set -e
set -x

. ./conf/snapback
. ./lib.sh

#pre_backup() { }
#post_backup() { }

# $1: path to snapshot
create_snapshot() {

    if ! is_subvol "$1"; then

        false

    fi

    subvol=${1#/}

    if [[ -z "$subvol" ]]; then

        subvol="@"

    fi

    mkdir -p $(dirname "$SNAPDIR/$subvol")

    btrfs subvolume snapshot -r "$1" "$SNAPDIR/$subvol.$(date "+%Y%m%d%H%M%S")"
    # create toupload file?

}

for subvol in $SUBVOLS; do

    create_snapshot "$subvol"

done

