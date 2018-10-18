#!/usr/bin/env bash

### Command to get DO API Key
#API_KEY_COMMAND=''
#API_KEY="$($API_KEY_COMMAND)"

### API Key if command not possible
#API_KEY=''

clear
echo 'Droplet name: '
read DROPLET_NAME

clear

echo 'Use custom image? (y/n)'
read CUSTOM_IMAGE

if [[ "$CUSTOM_IMAGE" == 'y' ]]
then
	echo 'Possible images: '
	doctl compute image list
else
	DISTRO_LIST="$(doctl compute image list-distribution)"
	APP_LIST="$(doctl compute image list-application)"
	ALL_LIST="${DISTRO_LIST}\n${APP_LIST}\n"
	echo 'Possible images: ' 
	printf "$ALL_LIST"
fi
sleep 1
printf "\n"
echo 'Image ID: '
read IMAGE


clear
echo 'Possible regions: '
doctl compute region list

sleep 1
printf "\n"
echo 'Region slug: '
read REGION_SLUG

clear
echo 'Possible droplet sizes: '
doctl compute size list

sleep 1
printf "\n"
echo 'Size slug: '
read SIZE_SLUG


clear 
echo 'Add SSH key? (y/n): '
read SSH_KEY

COMMAND="doctl compute droplet create $DROPLET_NAME --image $IMAGE --region $REGION_SLUG --size $SIZE_SLUG"


if [[ "$SSH_KEY" == 'y' ]]
then
	echo 'Possible SSH keys: '
	doctl compute ssh-key list
	printf "\n"
	echo 'SSH key ID: ' 
	read SSH_KEY_ID
	COMMAND="${COMMAND} --ssh-keys ${SSH_KEY_ID}"
fi


clear
echo 'Enable backups? (y/n): '
read BACKUPS

if [[ "$BACKUPS" == 'y' ]]
then
	COMMAND="${COMMAND} --enable-backups"
fi

printf "\n"
echo 'Enable IPv6? (y/n): '
read IPV6

if [[ "$IPV6" == 'y' ]]
then
	COMMAND="${COMMAND} --enable-ipv6"
fi

printf "\n"
echo 'Enable monitoring? (y/n): '
read MONITOR

if [[ "$MONITOR" == 'y' ]]
then
	COMMAND="${COMMAND} --enable-monitoring"
fi

printf "\n"
echo 'Enable private networking? (y/n): '
read PRIVATE_NET

if [[ "$PRIVATE_NET" == 'y' ]]
then
	COMMAND="${COMMAND} --enable-private-networking"
fi


printf "\n"
echo 'Add tag to droplet? (y/n): '
read TAG

if [[ "$TAG" == 'y' ]]
then
	echo 'Possible tags: '
	doctl compute tag list
	printf "\n"
	echo 'Tag name: '
	read TAG_NAME
	COMMAND="${COMMAND} --tag-name ${TAG_NAME}"
fi

if [[ -n "$API_KEY" ]]
then
	COMMAND="${COMMAND} --access-token ${API_KEY}" 
fi

eval "$COMMAND"
