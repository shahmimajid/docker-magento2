#!/bin/bash

docker-compose up -d 

# Wait for all docker is up
sleep 10

# Run the Magento2 installation
docker exec -it $(docker ps | grep "docker-magento2-base" |awk '{print $1}') /bin/bash /usr/local/bin/install-magento