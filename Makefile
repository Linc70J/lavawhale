# Tell Makefile to use bash
SHELL := /bin/bash

.PHONY: init-fpm init-swoole

init-fpm:
	mkdir -p ../deploy/docker
	cp .env.example .env
	cp .env.example ../deploy/docker/.env.dev
	cp docker-compose.yml.example docker-compose.yml
	cp nginx/sites/php-fpm.conf.example nginx/sites/default.conf
	cp php/xdebug.ini.example php/xdebug.ini
	cp web/supervisord.d/laravel-php-fpm.conf.example web/supervisord.d/laravel-php-fpm.conf
	cp worker/supervisord.d/laravel-schedule.conf.example worker/supervisord.d/laravel-schedule.conf
	cp worker/supervisord.d/laravel-worker.conf.example worker/supervisord.d/laravel-worker.conf

init-swoole:
	mkdir -p ../deploy/docker
	cp .env.example .env
	cp .env.example ../deploy/docker/.env.dev
	cp docker-compose.yml.example docker-compose.yml
	cp nginx/sites/swoole.conf.example nginx/sites/default.conf
	cp php/xdebug.ini.example php/xdebug.ini
	cp web/supervisord.d/laravel-swoole.conf.example web/supervisord.d/laravel-swoole.conf
	cp worker/supervisord.d/laravel-schedule.conf.example worker/supervisord.d/laravel-schedule.conf
	cp worker/supervisord.d/laravel-worker.conf.example worker/supervisord.d/laravel-worker.conf