#!/bin/bash

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "1 argument required, $# provided"

HOSTNAME=$1
echo >&2 "Waiting for host $HOSTNAME..."
until getent hosts $HOSTNAME > /dev/null ; do
     sleep 1;
done

IP=`getent hosts $HOSTNAME | cut -d" " -f1`
echo >&2 "$HOSTNAME ip is $IP"

echo $IP
