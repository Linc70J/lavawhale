#!/bin/bash

echo '大俠請選擇要使用哪個 Web Server: '
options=('FPM' 'Swoole')
select opt in "${options[@]}"
do
    case $opt in
        "FPM")
	        cp -i shared/web/supervisord.d/laravel-php-fpm.conf.example shared/web/supervisord.d/laravel-php-fpm.conf
	        cp -i shared/nginx/sites/php-fpm.conf.example shared/nginx/sites/default.conf
            break
            ;;
        "SWOOLE")
	        cp -i shared/web/supervisord.d/laravel-swoole.conf.example shared/web/supervisord.d/laravel-swoole.conf
	        cp -i shared/nginx/sites/swoole.conf.example shared/nginx/sites/default.conf
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

echo "大俠要使用Worker嗎?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
	        cp -i shared/worker/supervisord.d/laravel-schedule.conf.example shared/worker/supervisord.d/laravel-schedule.conf
	        cp -i shared/worker/supervisord.d/laravel-worker.conf.example shared/worker/supervisord.d/laravel-worker.conf
            break;;
        No ) break;;
        *) echo "invalid option $REPLY";;
    esac
done
