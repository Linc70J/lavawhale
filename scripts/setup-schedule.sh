#!/bin/bash

while true; do
    read -p "大俠要開啟Schedule功能嗎? (y/n [n]) " yn
    case $yn in
        [Yy]* ) cp -i deploy/shared/worker/laravel-schedule.conf.example deploy/shared/worker/laravel-schedule.conf; break;;
        [Nn]* ) exit;;
        * ) echo "invalid option $REPLY";;
    esac
done
