#!/usr/bin/env bash

export REGISTRY_HOST=
export REGISTRY_PASSWORD=

echo $REGISTRY_PASSWORD | docker login $REGISTRY_HOST -u larvata --password-stdin
docker-compose pull
docker-compose down -v
docker-compose up -d --remove-orphans