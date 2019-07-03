FROM node:10 as build-deps
WORKDIR /app
COPY . .
RUN yarn install
RUN yarn production

FROM nginx:1.15-alpine

RUN apk update \
    && apk upgrade \
    && apk add --no-cache openssl \
    && apk add --no-cache bash \
    && adduser -D -H -u 1000 -s /bin/bash www-data

ARG PHP_UPSTREAM_CONTAINER=php-fpm
ARG PHP_UPSTREAM_PORT=9000

# Set upstream conf and remove the default conf
RUN echo "upstream php-upstream { server ${PHP_UPSTREAM_CONTAINER}:${PHP_UPSTREAM_PORT}; }" > /etc/nginx/conf.d/upstream.conf \
    && rm /etc/nginx/conf.d/default.conf

# Set nginx configuration
COPY docker/nginx/nginx.conf /etc/nginx/
COPY docker/nginx/sites /etc/nginx/sites-available
COPY docker/nginx/ssl /etc/nginx/ssl

# Copy yarn output
COPY --from=build-deps /app/public /var/www/public

# Set nginx startup
COPY docker/nginx/startup.sh /opt/startup.sh
RUN sed -i 's/\r//g' /opt/startup.sh
CMD ["/bin/bash", "/opt/startup.sh"]

EXPOSE 80 443