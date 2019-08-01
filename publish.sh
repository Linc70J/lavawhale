#!/bin/bash

# docker configuration
mkdir -p ../deploy/docker
cp -i .env.example ../deploy/docker/.env.dev
cp -i docker-compose.yml.example ../deploy/docker/docker-compose.yml

# nginx configuration
mkdir -p ../deploy/shared/nginx
cp -r -i nginx/sites ../deploy/shared/nginx

# web configuration
cp -r -i web ../deploy/shared

# worker configuration
cp -r -i worker ../deploy/shared

# publish dockerignore
cp -i .dockerignore.example ../.dockerignore

# publish deploy configuration
cp -i init.sh ../deploy/init.sh
cp -i deploy.sh ../deploy/deploy.sh
cp -i docker-compose.yml.deploy ../deploy/docker-compose.yml

# publish Makefile
cp -i Makefile-example ../Makefile