#! /bin/bash

set -x
set -e

. ./lib.sh
. ./conf/snapback

BORGREPO="borg@kvm1.babioch.de:antares"
BORGARGS="-v --show-rc --progress --compression zlib,9"

#pre_backup() { }
#post_backup() { }

backup_snapshot() {

    subvol=$(get_subvol_from_snapshot "$1")
    date=$(get_date_from_snapshot "$1")

    if [[ -d "$SNAPDIR/$subvol" ]]; then

        btrfs subvolume delete "$SNAPDIR/$subvol"

    fi

    btrfs subvolume snapshot -r "$SNAPDIR/$1" "$SNAPDIR/$subvol"

    if [[ -f "$SNAPDIR/$subvol.exclude" ]]; then

        BORGARGS+=" --exclude-from $SNAPDIR/$subvol.exclude"

    fi

    cd "$SNAPDIR/$subvol"
    eval "borg create $BORGARGS $BORGREPO/$subvol::$date ."

    mv "$SNAPDIR/$1" "$SNAPDIR/$1.b"
    btrfs subvolume delete "$SNAPDIR/$subvol"

}

for snapshot in $(get_snapshots | egrep -v -e $(regex_flag "b")); do

    backup_snapshot $snapshot

done    

