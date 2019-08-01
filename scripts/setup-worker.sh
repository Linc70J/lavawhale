#!/bin/bash

echo "大俠要開啟Worker功能嗎?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
	        cp -i deploy/shared/worker/supervisord.d/laravel-worker.conf.example deploy/shared/worker/supervisord.d/laravel-worker.conf
            break;;
        No ) break;;
        *) echo "invalid option $REPLY";;
    esac
done