#! /bin/bash

set -e
#set -x

. ./lib.sh
. ./conf/snapback

BORGREPO="borg@kvm1.babioch.de:antares"
BORGARGS="-v --show-rc --stats --compression zlib,9"

#pre_backup() { }
#post_backup() { }

convert_ts() {

	year=${1:0:4}
	month=${1:4:2}
	day=${1:6:2}

	hour=${1:9:2}
	minute=${1:11:2}
	second=${1:13:2}
	tz=${1:15:5}

	date -u -d "$year-$month-$day $hour:$minute:$second $tz" "+%Y-%m-%dT%H:%M:%S"

}

backup_snapshot() {

    subvol=$(get_subvol_from_snapshot "$1")
    date=$(get_date_from_snapshot "$1")
    ts="$(convert_ts "$date")"

    if [[ -d "$SNAPDIR/$subvol" ]]; then

        btrfs subvolume delete "$SNAPDIR/$subvol" > /dev/null

    fi

    btrfs subvolume snapshot -r "$SNAPDIR/$1" "$SNAPDIR/$subvol" > /dev/null

    if [[ -f "$SNAPDIR/$subvol.exclude" ]]; then

        BORGARGS+=" --exclude-from $SNAPDIR/$subvol.exclude"

    fi

    cd "$SNAPDIR/$subvol"
    borg create $BORGARGS --timestamp $ts $BORGREPO/$subvol::$date .

    mv "$SNAPDIR/$1" "$SNAPDIR/$1.b"
    btrfs subvolume delete "$SNAPDIR/$subvol" > /dev/null

}

for snapshot in $(get_snapshots | egrep -v -e $(regex_flag "b")); do

    backup_snapshot $snapshot

done    

