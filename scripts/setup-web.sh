#!/bin/bash

echo '大俠請選擇要使用哪個 Web Server: '
options=('FPM' 'SWOOLE')
select opt in "${options[@]}"
do
    case $opt in
        "FPM")
            rm -rf deploy/shared/web/supervisord.d/laravel-swoole.conf
	          cp -i deploy/shared/nginx/sites/php-fpm.conf.example deploy/shared/nginx/sites/default.conf
            break;;
        "SWOOLE")
            echo 'Composer 檢查:'
            if grep --quiet swooletw/laravel-swoole composer.json; then
              echo composer package ok
            else
              echo '請安裝 [swooletw/laravel-swoole] : composer require swooletw/laravel-swoole'
              exit
            fi

            echo '.env 檢查:'
            if grep --quiet SWOOLE_HTTP_HOST .env; then
              echo .env ok
            else
              echo '未設定 [SWOOLE_HTTP_HOST] 需要幫大俠設定嗎？'
              select yn in "Yes" "No"; do
                case $yn in
                    Yes )
                        echo "SWOOLE_HTTP_HOST=0.0.0.0" >> .env
                        break;;
                    No ) break;;
                    *) echo "invalid option $REPLY";;
                esac
              done
            fi

            echo '.env.example 檢查:'
            if grep --quiet SWOOLE_HTTP_HOST .env.example; then
              echo .env.example ok
            else
              echo '未設定 [SWOOLE_HTTP_HOST] 需要幫大俠設定嗎？'
              select yn in "Yes" "No"; do
                case $yn in
                    Yes )
                        echo "SWOOLE_HTTP_HOST=0.0.0.0" >> .env.example
                        break;;
                    No ) break;;
                    *) echo "invalid option $REPLY";;
                esac
              done
            fi
	        cp -i deploy/shared/web/supervisord.d/laravel-swoole.conf.example deploy/shared/web/supervisord.d/laravel-swoole.conf
	        cp -i deploy/shared/nginx/sites/swoole.conf.example deploy/shared/nginx/sites/default.conf
            break;;
        *) echo "invalid option $REPLY";;
    esac
done