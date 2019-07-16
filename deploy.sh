#!/usr/bin/env bash

export REGISTRY_HOST=
export REGISTRY_PASSWORD=

echo $REGISTRY_PASSWORD | docker login $REGISTRY_HOST -u larvata --password-stdin
docker-compose pull
docker-compose down -v
docker-compose up -d --remove-orphans
sudo chown -R www-data:www-data shared
sudo chmod -R 0777 shared
docker-compose exec -T web php artisan migrate
# docker-compose exec -T web php artisan db:seed
