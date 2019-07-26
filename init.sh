#!/bin/bash

echo '部署檢查:'
if test -f "shared/.env"; then
    echo "shared/.env ok"
else
    echo "未設定 shared/.env"
fi

echo "大俠要開啟Schedule功能嗎?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
	        cp -i shared/worker/supervisord.d/laravel-schedule.conf.example shared/worker/supervisord.d/laravel-schedule.conf
            break;;
        No ) break;;
        *) echo "invalid option $REPLY";;
    esac
done

echo "大俠要開啟Worker功能嗎?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
	        cp -i shared/worker/supervisord.d/laravel-worker.conf.example shared/worker/supervisord.d/laravel-worker.conf
            break;;
        No ) break;;
        *) echo "invalid option $REPLY";;
    esac
done

echo '大俠請選擇要使用哪個 Web Server: '
options=('FPM' 'SWOOLE')
select opt in "${options[@]}"
do
    case $opt in
        "FPM")
            rm -rf shared/web/supervisord.d/laravel-swoole.conf
	        cp -i shared/nginx/sites/php-fpm.conf.example shared/nginx/sites/default.conf
            break
            ;;
        "SWOOLE")
            echo '.env 檢查:'
            if grep --quiet SWOOLE_HTTP_HOST shared/.env; then
              echo .env ok
            else
              echo '未設定 [SWOOLE_HTTP_HOST] 需要幫大俠設定嗎？'
              select yn in "Yes" "No"; do
                case $yn in
                    Yes )
                        echo "SWOOLE_HTTP_HOST=0.0.0.0" >> shared/.env
                        break;;
                    No ) break;;
                    *) echo "invalid option $REPLY";;
                esac
              done
            fi
	        cp -i shared/web/supervisord.d/laravel-swoole.conf.example shared/web/supervisord.d/laravel-swoole.conf
	        cp -i shared/nginx/sites/swoole.conf.example shared/nginx/sites/default.conf
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
