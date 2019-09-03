# Tell Makefile to use bash
SHELL := /bin/bash

.PHONY: first-setup reload setup-web build start stop down restart composer-install migrate seed clean bash

first-setup: ## 初始化專案環境
	git submodule init
	git submodule update
	cp deploy/config/xdebug.ini.example deploy/config/xdebug.ini
	cp deploy/shared/web/laravel-nginx.conf.example deploy/shared/web/laravel-nginx.conf
	make reload

reload: ## 配置 PHP 常用套件與環境
	bash docker/scripts/copy-env.sh
	bash docker/scripts/setup-schedule.sh
	bash docker/scripts/setup-worker.sh
	make setup-web

setup-web: ## 配置 php-fpm 或 Swoole
	bash docker/scripts/setup-web.sh

build: ## 編譯 Docker Images
	cd build; docker-compose build;

start: ## 啟動服務
	cd build; docker-compose up -d;

stop: ## 暫停服務
	cd build; docker-compose stop;

down: ## 停止服務
	cd build; docker-compose down;

restart: ## 重啓服務
	make down
	make start

composer-install: ## 在 Container 內執行 composer install
	cd build; docker-compose exec web composer install --ignore-platform-reqs

migrate: ## 在 Container 內執行 database migrate
	cd build; docker-compose exec web php artisan migrate

seed: ## 在 Container 內執行 database seed
	cd build; docker-compose exec web php artisan db:seed

clean: ## 在 Container 內清理 Laravel Cache
	cd build; docker-compose exec web php artisan cache:clear
	cd build; docker-compose exec web php artisan route:clear
	cd build; docker-compose exec web php artisan view:clear

bash: ## 進行 Container 的 Shell
	cd build; docker-compose exec web bash