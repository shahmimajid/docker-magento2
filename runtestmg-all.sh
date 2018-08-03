#!/bin/bash

# Run the Magento2 Unit Test
docker exec --user www-data $(docker ps | grep "docker-magento2-base" |awk '{print $1}') php -f bin/magento dev:tests:run all