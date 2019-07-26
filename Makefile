# Tell Makefile to use bash
SHELL := /bin/bash

.PHONY: publish init setup-fpm setup-swoole

publish:
	mkdir -p ../deploy/docker
    # docker configuration
	cp -i .env.example ../deploy/docker/.env.dev
	cp -i docker-compose.yml.example ../deploy/docker/docker-compose.yml
	mkdir -p ../deploy/shared/nginx
    # nginx configuration
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

init:
	cp -i ../deploy/docker/.env.dev .env
	cp -i ../deploy/docker/docker-compose.yml docker-compose.yml
	cp -i php/xdebug.ini.example php/xdebug.ini
	bash dev-init.sh

setup-fpm:
	cp ../deploy/shared/nginx/sites/php-fpm.conf nginx/sites/default.conf
	docker-compose exec -T nginx nginx -s reload

setup-swoole:
	cp ../deploy/shared/nginx/sites/swoole.conf nginx/sites/default.conf
	docker-compose exec -T nginx nginx -s reload
