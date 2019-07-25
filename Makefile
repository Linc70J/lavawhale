# Tell Makefile to use bash
SHELL := /bin/bash

.PHONY: publish publish-ignore init setup-fpm setup-swoole

publish:
	mkdir -p ../deploy/docker
	mkdir -p ../deploy/shared/web
	mkdir -p ../deploy/shared/worker
	mkdir -p ../deploy/shared/nginx/sites
	cp -i deploy.sh ../deploy/deploy.sh
	cp -i docker-compose.yml.deploy ../deploy/docker-compose.yml
	cp -i .env.example ../deploy/docker/.env.dev
	cp -i docker-compose.yml.example ../deploy/docker/docker-compose.yml
	cp -r -i web ../deploy/shared/web
	cp -r -i worker ../deploy/shared/worker
	cp -r -i nginx/sites ../deploy/shared/nginx/sites

publish-ignore:
	cp -i .dockerignore.example ../.dockerignore

init:
	cp -i php/xdebug.ini.example php/xdebug.ini
	cp -i .env.example .env
	cp -i docker-compose.yml.example docker-compose.yml
	cp -i web/supervisord.d/laravel-php-fpm.conf.example web/supervisord.d/laravel-php-fpm.conf
	cp -i web/supervisord.d/laravel-swoole.conf.example web/supervisord.d/laravel-swoole.conf
	cp -i worker/supervisord.d/laravel-schedule.conf.example worker/supervisord.d/laravel-schedule.conf
	cp -i worker/supervisord.d/laravel-worker.conf.example worker/supervisord.d/laravel-worker.conf
	cp -i nginx/sites/php-fpm.conf.example nginx/sites/default.conf

setup-fpm:
	cp ../deploy/shared/nginx/sites/php-fpm.conf nginx/sites/default.conf
	docker-compose exec -T nginx nginx -s reload

setup-swoole:
	cp ../deploy/shared/nginx/sites/swoole.conf nginx/sites/default.conf
	docker-compose exec -T nginx nginx -s reload
