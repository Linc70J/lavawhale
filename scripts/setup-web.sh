#!/bin/bash

echo '大俠請選擇要使用哪個 Web Server: '
options=('FPM' 'SWOOLE')
select opt in "${options[@]}"
do
    case $opt in
        "FPM")
            rm -rf deploy/shared/web/laravel-swoole.conf
	          cp -i deploy/shared/sites/php-fpm.conf.example deploy/shared/sites/default.conf
            break;;
        "SWOOLE")
            echo 'Composer 檢查:'
            if grep --quiet swooletw/laravel-swoole composer.json; then
              echo composer package ok
            else
              echo '請安裝 [swooletw/laravel-swoole] : composer require swooletw/laravel-swoole'
              exit
            fi
	          cp -i deploy/shared/web/laravel-swoole.conf.example deploy/shared/web/laravel-swoole.conf
	          cp -i deploy/shared/sites/swoole.conf.example deploy/shared/sites/default.conf
            break;;
        *) echo "invalid option $REPLY";;
    esac
done