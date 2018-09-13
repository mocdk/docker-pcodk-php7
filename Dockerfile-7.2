FROM php:7.2-fpm

MAINTAINER Jan-Erik Revsbech <jer@peytz.dk>
RUN apt-get update && apt-get install -y curl wget git zlib1g-dev libicu-dev g++ libpng-dev libjpeg-dev libmcrypt-dev libxml2-dev nano vim

RUN echo 'date.timezone = Europe/Copenhagen' > /usr/local/etc/php/conf.d/date.ini
RUN echo 'memory_limit = 512M' > /usr/local/etc/php/conf.d/memory.ini
RUN echo 'upload_max_filesize = 100M' > /usr/local/etc/php/conf.d/upload_limit.ini
RUN echo 'post_max_size = 100M' >> /usr/local/etc/php/conf.d/upload_limit.ini

RUN docker-php-ext-configure intl && docker-php-ext-install pdo_mysql zip mysqli pcntl soap gd  gettext intl bcmath iconv 

ENV PHPREDIS_VERSION 3.0.0

RUN mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts \
    && docker-php-ext-install redis

WORKDIR /var/www/application
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
