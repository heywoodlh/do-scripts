#!/usr/bin/env bash

clear
echo 'Current droplets: '
doctl compute droplet list

printf "\n"
echo 'Droplet ID or name: '
read DROPLET_ID
doctl compute droplet delete "$DROPLET_ID"
