#!/bin/bash

# Unit Test : 
docker exec -it $(docker ps | grep "docker-magento2-base" |awk '{print $1}') ./var/www/html/bin/magento dev:tests:run static