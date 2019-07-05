# Tell Makefile to use bash
SHELL := /bin/bash

.PHONY: publish setup-fpm setup-swoole setup-worker

publish:
	cp -r web ../deploy/shared/web
	cp -r worker ../deploy/shared/worker
	cp deploy.sh ../deploy/deploy.sh
	cp docker-compose.yml.deploy ../deploy/docker-compose.yml
	cp .env.example ../deploy/docker/.env.dev
	cp docker-compose.yml.example ../deploy/docker/docker-compose.yml
	cp php/xdebug.ini.example php/xdebug.ini
	cp .env.example .env
	cp docker-compose.yml.example docker-compose.yml

setup-fpm:
	cp nginx/sites/php-fpm.conf.example nginx/sites/default.conf
	cp web/supervisord.d/laravel-php-fpm.conf.example web/supervisord.d/laravel-web-service.conf

setup-swoole:
	cp nginx/sites/swoole.conf.example nginx/sites/default.conf
	cp web/supervisord.d/laravel-swoole.conf.example web/supervisord.d/laravel-web-service.conf

setup-worker:
	cp worker/supervisord.d/laravel-schedule.conf.example worker/supervisord.d/laravel-schedule.conf
	cp worker/supervisord.d/laravel-worker.conf.example worker/supervisord.d/laravel-worker.conf