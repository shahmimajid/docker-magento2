#!/bin/bash

if [ ! -d "$FOLDER" ] ; then
     git clone "$docker_magento2_url" "$FOLDER"
else
     cd "$FOLDER"
     git pull "$docker_magento2_url"
fi

sed -i '/s/local\.magento/$DEV\_URL/g' /home/$user/docker-magento2/env

sleep 2
cd /home/$user/$FOLDER
bash install.sh

