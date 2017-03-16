#!/bin/bash

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "Need to specify 1 argument, the node to check if it's up to"

NODE=$1

RESULT=$(curl -sS http://$NODE:7000/getinfo | grep status | grep OK | wc -l)

if [ $RESULT -eq 1 ]; then
    echo Node $NODE is up;
    exit 0
else
    echo Node $NODE is not up;
    exit 1
fi
