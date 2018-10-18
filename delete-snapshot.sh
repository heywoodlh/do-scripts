#!/usr/bin/env bash

clear
DROPLET_LIST="$(doctl compute snapshot list)"
echo 'Current snapshots: '
echo "$SNAPSHOT_LIST"

printf "\n"
echo 'Snapshot ID: '
read SNAPSHOT_ID

clear
printf "\n"
echo 'Selection: '
echo "$SNAPSHOT_LIST" | grep "$SNAPSHOT_ID"

printf "\n"
doctl compute snapshot delete "$SNAPSHOT_ID"

