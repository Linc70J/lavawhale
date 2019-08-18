# Tell Makefile to use bash
SHELL := /bin/bash

.PHONY: first-setup reload setup-web build up stop down restart composer-install migrate seed clean bash

first-setup:
	git submodule init
	git submodule update
	cp -i deploy/config/xdebug.ini.example deploy/config/xdebug.ini
	cp -i deploy/shared/web/laravel-nginx.conf.example deploy/shared/web/laravel-nginx.conf
	make reload

reload:
	cp -i build/.env.dev build/.env
	bash docker/scripts/setup-schedule.sh
	bash docker/scripts/setup-worker.sh
	make setup-web

setup-web:
	bash docker/scripts/setup-web.sh

build:
	cd build; docker-compose build;

up:
	cd build; docker-compose up -d;

stop:
	cd build; docker-compose stop;

down:
	cd build; docker-compose down;

restart:
	make down
	make up

composer-install:
	cd build; docker-compose exec web composer install --ignore-platform-reqs

migrate:
	cd build; docker-compose exec web php artisan migrate

seed:
	cd build; docker-compose exec web php artisan db:seed

clean:
	cd build; docker-compose exec web php artisan cache:clear

bash:
	cd build; docker-compose exec web bash