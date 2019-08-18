#!/bin/bash

echo "大俠要開啟Schedule功能嗎?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
	        cp -i deploy/shared/worker/laravel-schedule.conf.example deploy/shared/worker/laravel-schedule.conf
            break;;
        No ) break;;
        *) echo "invalid option $REPLY";;
    esac
done