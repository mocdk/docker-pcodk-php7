FROM php:7-fpm

MAINTAINER Jan-Erik Revsbech <jer@peytz.dk>
RUN apt-get update && apt-get install -y curl wget git zlib1g-dev libicu-dev g++

RUN echo 'date.timezone = Europe/Copenhagen' > /usr/local/etc/php/conf.d/date.ini

RUN docker-php-ext-configure intl && docker-php-ext-install pdo pdo_mysql zip intl 

ENV PHPREDIS_VERSION 3.0.0

RUN mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts \
    && docker-php-ext-install redis

WORKDIR /var/www/application
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer