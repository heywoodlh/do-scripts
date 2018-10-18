#!/usr/bin/env bash

clear
DROPLET_LIST="$(doctl compute droplet list)"
echo 'Current droplets: '
echo "$DROPLET_LIST"

printf "\n"
echo 'Droplet ID or name: '
read DROPLET_ID

clear
printf "\n"
doctl compute droplet-action power-on "$DROPLET_ID"
