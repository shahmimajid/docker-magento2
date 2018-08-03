#!/bin/bash

# Run the Magento2 Unit Test
docker exec --user www-data $(docker ps | grep "docker-magento2-base" |awk '{print $1}') php "-f vendor/bin/phpunit -- -c dev/tests/unit/phpunit.xml.dist"