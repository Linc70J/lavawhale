FROM nginx:1.17-alpine

RUN apk update \
    && apk upgrade \
    && apk add --no-cache openssl \
    && apk add --no-cache bash

RUN set -x ; \
    addgroup -g 82 -S www-data ; \
    adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

ARG PHP_FPM_PORT=9000
ARG PHP_SWOOLE_PORT=1215

# Set upstream conf and remove the default conf
RUN echo "upstream php-upstream { server web:${PHP_FPM_PORT}; }" > /etc/nginx/conf.d/upstream.conf \
#    && echo "upstream swoole-upstream { server web:${PHP_SWOOLE_PORT}; }" > /etc/nginx/conf.d/upstream.conf \
    && rm /etc/nginx/conf.d/default.conf

# Set nginx configuration
COPY docker/nginx/nginx.conf /etc/nginx/
COPY docker/nginx/sites /etc/nginx/sites-available
COPY docker/nginx/ssl /etc/nginx/ssl

# Set static page
COPY /public /var/www/public

# Set nginx startup flow
COPY docker/nginx/startup.sh /opt/startup.sh
RUN sed -i 's/\r//g' /opt/startup.sh
CMD ["/bin/bash", "/opt/startup.sh"]

EXPOSE 80 443
