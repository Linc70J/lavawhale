#!/bin/bash

if [ -f "/etc/supervisord.d/laravel-swoole.conf" ]; then
  if [ -f "/usr/local/etc/php/conf.d/docker-php-ext-xdebug.disable" ]; then
    mv /usr/local/etc/php/conf.d/docker-php-ext-xdebug.disable /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
  fi
else
  if [ -f "/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini" ]; then
    mv /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.disable
  fi
fi

/usr/bin/supervisord -n -c /etc/supervisord.conf