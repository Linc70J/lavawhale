#!/bin/bash

if [ ${APP_ENV} = 'PRODUCTION' ]; then \
  composer install;
fi

if [ ${APP_ENV} = 'STAGING' ]; then \
  composer install --no-dev;
fi