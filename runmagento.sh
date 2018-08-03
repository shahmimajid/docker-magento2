#!/bin/bash

# Run the Magento2 installation
docker exec $(docker ps | grep "docker-magento2-base" |awk '{print $1}') /bin/bash /usr/local/bin/install-magento