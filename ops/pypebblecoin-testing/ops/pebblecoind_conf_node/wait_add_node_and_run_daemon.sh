#!/bin/bash

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "Need to specify 1 argument, the node to connect to"

echo add-exclusive-node=`/daemon/bin/wait_and_get_link_ip.sh $1`:6000 >> /daemon/data/pebblecoin.conf
/daemon/bin/entrypoint.sh
