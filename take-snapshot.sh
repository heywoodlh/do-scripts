#!/usr/bin/env bash

clear
DROPLET_LIST="$(doctl compute droplet list)"
echo 'Current droplets: '
echo "$DROPLET_LIST"
printf "\n"
echo 'Droplet ID: '
read DROPLET_ID

printf "\n"
echo 'Selection: '
echo "$DROPLET_LIST" | grep "$DROPLET_ID"

echo 'Snapshot name: '
read "$NAME"

doctl compute droplet-action snapshot "$DROPLET_ID" --snapshot-name "$NAME"
