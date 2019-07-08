# Tell Makefile to use bash
SHELL := /bin/bash

.PHONY: publish publish-ignore setup-fpm setup-swoole setup-worker

publish:
	cp -rf -n web ../deploy/shared/web
	cp -rf -n worker ../deploy/shared/worker
	cp -n deploy.sh ../deploy/deploy.sh
	cp -n docker-compose.yml.deploy ../deploy/docker-compose.yml
	cp -n .env.example ../deploy/docker/.env.dev
	cp -n docker-compose.yml.example ../deploy/docker/docker-compose.yml
	cp -n php/xdebug.ini.example php/xdebug.ini
	cp -n .env.example .env
	cp -n docker-compose.yml.example docker-compose.yml

publish-ignore:
	cp -n .dockerignore.example ../.dockerignore

setup-fpm:
	cp -n nginx/sites/php-fpm.conf.example nginx/sites/default.conf
	cp -n web/supervisord.d/laravel-php-fpm.conf.example web/supervisord.d/laravel-web-service.conf

setup-swoole:
	cp -n nginx/sites/swoole.conf.example nginx/sites/default.conf
	cp -n web/supervisord.d/laravel-swoole.conf.example web/supervisord.d/laravel-web-service.conf

setup-worker:
	cp -n worker/supervisord.d/laravel-schedule.conf.example worker/supervisord.d/laravel-schedule.conf
	cp -n worker/supervisord.d/laravel-worker.conf.example worker/supervisord.d/laravel-worker.conf