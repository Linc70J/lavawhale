FROM linc70j/php-swoole:1.0.0

# Set Environment Variables
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

###########################################################################
# SOAP:
###########################################################################

ARG INSTALL_SOAP=false

RUN if [ ${INSTALL_SOAP} = true ]; then \
    # Install the soap extension
    rm /etc/apt/preferences.d/no-debian-php && \
    apt-get -y install libxml2-dev php-soap && \
    docker-php-ext-install soap \
;fi

###########################################################################
# XSL:
###########################################################################

ARG INSTALL_XSL=false

RUN if [ ${INSTALL_XSL} = true ]; then \
    # Install the xsl extension
    apt-get -y install libxslt-dev && \
    docker-php-ext-install xsl \
;fi

###########################################################################
# bcmath:
###########################################################################

ARG INSTALL_BCMATH=false

RUN if [ ${INSTALL_BCMATH} = true ]; then \
    # Install the bcmath extension
    docker-php-ext-install bcmath \
;fi

###########################################################################
# IMAP:
###########################################################################

ARG INSTALL_IMAP=false

RUN if [ ${INSTALL_IMAP} = true ]; then \
    apt-get install -y libc-client-dev libkrb5-dev && \
    rm -r /var/lib/apt/lists/* && \
    docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install imap \
;fi

###########################################################################
# FFMPEG:
###########################################################################

USER root

ARG INSTALL_FFMPEG=false

RUN if [ ${INSTALL_FFMPEG} = true ]; then \
    apt-get -y install ffmpeg \
;fi

###########################################################################
# SSH2:
###########################################################################

ARG INSTALL_SSH2=false

RUN if [ ${INSTALL_SSH2} = true ]; then \
    # Install the ssh2 extension
    apt-get -y install libssh2-1-dev && \
    pecl install -a ssh2-1.1.2 && \
    docker-php-ext-enable ssh2 \
;fi

###########################################################################
# Pcntl
###########################################################################

ARG INSTALL_PCNTL=false
RUN if [ ${INSTALL_PCNTL} = true ]; then \
    # Installs pcntl, helpful for running Horizon
    docker-php-ext-install pcntl \
;fi

###########################################################################
# RDKAFKA:
###########################################################################

ARG INSTALL_RDKAFKA=false

RUN if [ ${INSTALL_RDKAFKA} = true ]; then \
    apt-get install -y librdkafka-dev && \
    pecl install rdkafka && \
    docker-php-ext-enable rdkafka \
;fi

###########################################################################
# PHP Memcached:
###########################################################################

ARG INSTALL_MEMCACHED=false

RUN if [ ${INSTALL_MEMCACHED} = true ]; then \
    # Install the php memcached extension
    curl -L -o /tmp/memcached.tar.gz "https://github.com/php-memcached-dev/php-memcached/archive/php7.tar.gz" \
    && mkdir -p memcached \
    && tar -C memcached -zxvf /tmp/memcached.tar.gz --strip 1 \
    && ( \
        cd memcached \
        && phpize \
        && ./configure \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r memcached \
    && rm /tmp/memcached.tar.gz \
    && docker-php-ext-enable memcached \
;fi

###########################################################################
# Image
###########################################################################

USER root

ARG INSTALL_IMAGE=false

RUN if [ ${INSTALL_IMAGE} = true ]; then \
    apt-get install -y libmagickwand-dev imagemagick && \
    # Install the PHP gd library
    docker-php-ext-configure gd \
    --with-jpeg-dir=/usr/lib \
    --with-freetype-dir=/usr/include/freetype2 && \
    docker-php-ext-install gd && \
    # Install the PHP imagick library
    pecl install imagick && \
    docker-php-ext-enable imagick \
;fi

###########################################################################
# Exif:
###########################################################################

ARG INSTALL_EXIF=false

RUN if [ ${INSTALL_EXIF} = true ]; then \
    # Enable Exif PHP extentions requirements
    docker-php-ext-install exif \
;fi

###########################################################################
# pgsql
###########################################################################

ARG INSTALL_PGSQL=false

RUN if [ ${INSTALL_PGSQL} = true ]; then \
    # Install the pgsql extension
    docker-php-ext-install pdo_pgsql && \
    docker-php-ext-install pgsql \
;fi

###########################################################################
# MongoDB:
###########################################################################

ARG INSTALL_MONGO=false

RUN if [ ${INSTALL_MONGO} = true ]; then \
    # Install the mongodb extension
    pecl install mongodb && \
    docker-php-ext-enable mongodb \
;fi

###########################################################################
# SQL SERVER:
###########################################################################

ARG INSTALL_MSSQL=false

RUN set -eux; \
  if [ ${INSTALL_MSSQL} = true ]; then \
    ###########################################################################
    # Ref from https://github.com/Microsoft/msphpsql/wiki/Dockerfile-for-adding-pdo_sqlsrv-and-sqlsrv-to-official-php-image
    ###########################################################################
    # Add Microsoft repo for Microsoft ODBC Driver 13 for Linux
    apt-get install -y apt-transport-https gnupg \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update -yqq \
    # Install Dependencies
    && ACCEPT_EULA=Y apt-get install -y unixodbc unixodbc-dev libgss3 odbcinst msodbcsql17 locales \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    # link local aliases
    && ln -sfn /etc/locale.alias /usr/share/locale/locale.alias \
    && locale-gen \
    # Install pdo_sqlsrv and sqlsrv from PECL. Replace pdo_sqlsrv-4.1.8preview with preferred version.
    && pecl install pdo_sqlsrv sqlsrv \
    && docker-php-ext-enable pdo_sqlsrv sqlsrv \
    && php -m | grep -q 'pdo_sqlsrv' \
    && php -m | grep -q 'sqlsrv' \
  ;fi

###########################################################################
# Mysqli Modifications:
###########################################################################

ARG INSTALL_MYSQLI=false

RUN if [ ${INSTALL_MYSQLI} = true ]; then \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-install mysqli \
;fi

###########################################################################
# YAML:
###########################################################################

USER root

ARG INSTALL_YAML=false

RUN if [ ${INSTALL_YAML} = true ]; then \
    apt-get install libyaml-dev -y && \
    pecl install yam && \
    docker-php-ext-enable yaml \
;fi

###########################################################################
# PHP REDIS EXTENSION
###########################################################################

ARG INSTALL_PHPREDIS=false

RUN if [ ${INSTALL_PHPREDIS} = true ]; then \
    # Install Php Redis Extension
    printf "\n" | pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis \
;fi

###########################################################################
# Human Language and Character Encoding Support:
###########################################################################

ARG INSTALL_INTL=false

RUN if [ ${INSTALL_INTL} = true ]; then \
    # Install intl and requirements
    apt-get install -y zlib1g-dev libicu-dev g++ && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl \
;fi

###########################################################################
# xDebug:
###########################################################################

ARG INSTALL_XDEBUG=false

RUN if [ ${INSTALL_XDEBUG} = true ]; then \
  # Install the xdebug extension
  pecl install xdebug && \
  docker-php-ext-enable xdebug \
;fi

#
#--------------------------------------------------------------------------
# Final Touch
#--------------------------------------------------------------------------
#

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy laravel configuration
COPY ./docker/php/laravel.ini /usr/local/etc/php/conf.d
COPY ./docker/php/xlaravel.pool.conf /usr/local/etc/php-fpm.d/
# Copy xdebug configuration for remote debugging
COPY ./docker/php/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
# Copy opcache configuration
COPY ./docker/php/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
# Copy php configuration
COPY ./docker/php/php.ini /usr/local/etc/php/php.ini
# Copy supervisord.d configuration
COPY ./docker/php/supervisord.conf /etc/supervisord.conf
# Copy project
COPY ./ /var/www

USER root

RUN usermod -u 1000 www-data

WORKDIR /var/www

ARG COMPOSER_INSTALL=false
ARG COMPOSER_INSTALL_DEV=false

RUN if [ ${COMPOSER_INSTALL} = true ]; then \
    if [ ${COMPOSER_INSTALL_DEV} = true ]; then \
        composer install; \
    else \
        composer install --no-dev; \
    fi \
;fi

RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

ENTRYPOINT ["/usr/bin/supervisord"]

CMD ["-n", "-c", "/etc/supervisord.conf"]