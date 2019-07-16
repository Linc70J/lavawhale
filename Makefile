# Tell Makefile to use bash
SHELL := /bin/bash

.PHONY: publish publish-ignore setup-fpm setup-swoole

publish:
    mkdir -p ../deploy/docker
	cp -n deploy.sh ../deploy/deploy.sh
	cp -n docker-compose.yml.deploy ../deploy/docker-compose.yml
	cp -n .env.example ../deploy/docker/.env.dev
	cp -n docker-compose.yml.example ../deploy/docker/docker-compose.yml
	cp -n php/xdebug.ini.example php/xdebug.ini
	cp -n .env.example .env
	cp -n docker-compose.yml.example docker-compose.yml
	cp -n web/supervisord.d/laravel-php-fpm.conf.example web/supervisord.d/laravel-php-fpm.conf
	cp -n web/supervisord.d/laravel-swoole.conf.example web/supervisord.d/laravel-swoole.conf
	cp -n worker/supervisord.d/laravel-schedule.conf.example worker/supervisord.d/laravel-schedule.conf
	cp -n worker/supervisord.d/laravel-worker.conf.example worker/supervisord.d/laravel-worker.conf
	cp -n nginx/sites/php-fpm.conf.example nginx/sites/default.conf
	cp -rf -n web ../deploy/shared/web
	cp -rf -n worker ../deploy/shared/worker
	cp -rf -n nginx/sites ../deploy/shared/nginx/sites
	cp -rf -n nginx/ssl ../deploy/shared/nginx/ssl
	cp nginx/sites/php-fpm.conf.example ../deploy/shared/nginx/sites/php-fpm.conf
	cp nginx/sites/swoole.conf.example ../deploy/shared/nginx/sites/swoole.conf

publish-ignore:
	cp -n .dockerignore.example ../.dockerignore

setup-fpm:
	cp ../deploy/shared/nginx/sites/php-fpm.conf nginx/sites/default.conf
	docker-compose exec -T nginx nginx -s reload

setup-swoole:
	cp ../deploy/shared/nginx/sites/swoole.conf nginx/sites/default.conf
	docker-compose exec -T nginx nginx -s reload
