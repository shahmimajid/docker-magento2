#!/bin/bash

# Run the Magento2 Unit Test
docker exec $(docker ps | grep "docker-magento2-base" |awk '{print $1}') /bin/bash "su -l www-data && cd html && php -f vendor/bin/phpunit -- -c dev/tests/unit/phpunit.xml.dist"