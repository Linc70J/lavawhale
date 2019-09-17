FROM linc70j/php-swoole:2.0.0-beta

# Set Environment Variables
ENV DEBIAN_FRONTEND noninteractive

ARG INSTALL_SSH2=false
ARG INSTALL_SOAP=false
ARG INSTALL_XSL=false
ARG INSTALL_BCMATH=false
ARG INSTALL_IMAP=false
ARG INSTALL_IMAGICK=false
ARG INSTALL_MYSQLI=false
ARG INSTALL_MSSQL=false
ARG INSTALL_MONGO=false
ARG INSTALL_PGSQL=false
ARG INSTALL_SOCKETS=false
ARG INSTALL_RDKAFKA=false
ARG INSTALL_PHPREDIS=false
ARG INSTALL_NODE=false
ARG INSTALL_YARN=false

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    # SSH2:
    if [ ${INSTALL_SSH2} = true ]; then \
        apt-get -y install libssh2-1-dev && \
        pecl install -a ssh2-1.1.2 && \
        docker-php-ext-enable ssh2 \
    ;fi && \
    # SOAP:
    if [ ${INSTALL_SOAP} = true ]; then \
        rm /etc/apt/preferences.d/no-debian-php && \
        apt-get -y install libxml2-dev php-soap && \
        docker-php-ext-install soap \
    ;fi && \
    # XSL:
    if [ ${INSTALL_XSL} = true ]; then \
        apt-get -y install libxslt-dev && \
        docker-php-ext-install xsl \
    ;fi && \
    # BCMath:
    if [ ${INSTALL_BCMATH} = true ]; then \
        docker-php-ext-install bcmath \
    ;fi && \
    # IMAP:
    if [ ${INSTALL_IMAP} = true ]; then \
        apt-get install -y libc-client-dev libkrb5-dev && \
        docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
        docker-php-ext-install imap \
    ;fi && \
    # Imagick
    if [ ${INSTALL_IMAGICK} = true ]; then \
        apt-get install -y libmagickwand-dev imagemagick && \
        pecl install imagick && \
        docker-php-ext-enable imagick \
    ;fi && \
    # MySQLi:
    if [ ${INSTALL_MYSQLI} = true ]; then \
        docker-php-ext-install pdo_mysql && \
        docker-php-ext-install mysqli \
    ;fi && \
    # MongoDB:
    if [ ${INSTALL_MONGO} = true ]; then \
        pecl install mongodb && \
        docker-php-ext-enable mongodb \
    ;fi && \
    # PGSql:
    if [ ${INSTALL_PGSQL} = true ]; then \
        docker-php-ext-install pdo_pgsql pgsql \
    ;fi && \
    # SOCKETS:
    if [ ${INSTALL_SOCKETS} = true ]; then \
        docker-php-ext-install sockets \
    ;fi && \
    # RDKAFKA:
    if [ ${INSTALL_RDKAFKA} = true ]; then \
        apt-get install -y librdkafka-dev && \
        pecl install rdkafka && \
        docker-php-ext-enable rdkafka \
    ;fi && \
    # PHP REDIS EXTENSION:
    if [ ${INSTALL_PHPREDIS} = true ]; then \
        printf "\n" | pecl install -o -f redis \
        &&  rm -rf /tmp/pear \
        &&  docker-php-ext-enable redis \
    ;fi && \
    # Node:
    if [ ${INSTALL_YARN} = true ]; then \
        apt-get -y install nodejs yarn; \
    else \
        if [ ${INSTALL_NODE} = true ]; then \
            apt-get -y install nodejs; \
        fi \
    ;fi && \
    # SQL SERVER:
    set -eux; \
    if [ ${INSTALL_MSSQL} = true ]; then \
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
    ;fi && \
    buildDeps='gcc make autoconf libc-dev pkg-config' && \
    apt-get purge -y --auto-remove $buildDeps && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

#
#--------------------------------------------------------------------------
# Final Touch
#--------------------------------------------------------------------------
#

# Copy project
COPY ./ /var/www

USER root

RUN usermod -u 1000 www-data

WORKDIR /var/www

ARG APP_ENV='DEVELOP'

    # Copy nginx configuration
RUN cp deploy/config/nginx.conf /etc/nginx/ && \
    rm /etc/nginx/conf.d/default.conf && \
    cp -r deploy/shared/sites /etc/nginx/sites-available && \
    cp deploy/shared/sites/php-fpm.conf.example /etc/nginx/sites-available/default.conf && \
    cp -r deploy/shared/ssl /etc/nginx/ssl && \
    # Copy laravel configuration
    cp deploy/config/laravel.ini /usr/local/etc/php/conf.d && \
    cp deploy/config/xlaravel.pool.conf /usr/local/etc/php-fpm.d && \
    # Copy opcache configuration
    cp deploy/config/opcache.ini /usr/local/etc/php/conf.d/opcache.ini && \
    # Copy php configuration
    cp deploy/config/php.ini /usr/local/etc/php/php.ini && \
    # Copy supervisord.d configuration
    cp deploy/config/startup.sh /opt/startup.sh && \
    cp deploy/config/supervisord.conf /etc/supervisord.conf && \
    # Setup nginx
    mkdir /etc/supervisord.d && \
    cp deploy/shared/web/laravel-nginx.conf.example /etc/supervisord.d/laravel-nginx.conf && \
    # Custom build setting
    bash deploy/config/build.sh && \
    rm -rf docker deploy build

CMD ["/bin/bash", "/opt/startup.sh"]

EXPOSE 80 443 5000