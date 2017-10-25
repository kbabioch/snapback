#! /bin/bash

# $1: path to test
is_subvol() {

    btrfs subvolume show "$1" >/dev/null 2>&1

}


get_subvols() {

    for snapshot in $(btrfs subvolume list -s /.snapshots/ | awk '{print $NF}'); do

        get_subvol_from_snapshot $snapshot

    done | sort | uniq

}

# $1: name of subvol (optional) 
get_snapshots() {

    btrfs subvolume list -r -s /.snapshots/ | awk '{print $NF}' | grep "$1"

}

# $1: snapshot name
get_subvol_from_snapshot() {

    IFS=. read name date flags <<< $1
    echo $name

}

# $1: snapshot name
get_date_from_snapshot() {

    IFS=. read name date flags <<< $1
    echo $date

}

# $1: snapshot name
get_flags_from_snapshot() {

    IFS=. read name date flags <<< $1
    echo $flags

}

# $1: flag
regex_flag() {

    # todo: warn if no flag given?
    echo "^[a-zA-Z@/]+\.[0-9]{8}T[0-9]{6}[+\-][0-9]{4}\..*${1}"

}

