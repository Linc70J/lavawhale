#!/bin/bash

if [ ${APP_ENV} = 'PRODUCTION' ]; then \
  echo 'Is production';
  composer install --no-dev;
fi

if [ ${APP_ENV} = 'STAGING' ]; then \
  echo 'Is staging';
  composer install;
fi

if [ ${APP_ENV} = 'DEVELOP' ]; then \
  echo 'Is develop';
fi