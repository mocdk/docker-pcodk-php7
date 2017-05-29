FROM php:7-fpm

MAINTAINER Jan-Erik Revsbech <jer@peytz.dk>
RUN apt-get update && apt-get install -y curl wget git zlib1g-dev libicu-dev g++ libpng12-dev libjpeg-dev libmcrypt-dev libxml2-dev nano

RUN echo 'date.timezone = Europe/Copenhagen' > /usr/local/etc/php/conf.d/date.ini

RUN docker-php-ext-configure intl && docker-php-ext-install pdo pdo_mysql zip mysqli pcntl mcrypt soap gd

ENV PHPREDIS_VERSION 3.0.0

RUN mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts \
    && docker-php-ext-install redis
    
RUN touch /usr/local/etc/php/conf.d/xdebug.ini; \
echo xdebug.remote_enable=1 >> /usr/local/etc/php/conf.d/xdebug.ini; \
echo xdebug.remote_connect_back=1 >> /usr/local/etc/php/conf.d/xdebug.ini; \
echo xdebug.remote_port=9000 >> /usr/local/etc/php/conf.d/xdebug.ini;
RUN    mkdir ~/software && \
cd  ~/software/ && \
wget --no-check-certificate http://xdebug.org/files/xdebug-2.4.0rc4.tgz && \
tar -xvzf xdebug-2.4.0rc4.tgz && \
cd xdebug-2.4.0RC4 && \
phpize && \
./configure && \
make && \
cp modules/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20151012 && \
echo "zend_extension = /usr/local/lib/php/extensions/no-debug-non-zts-20151012/xdebug.so" >> /usr/local/etc/php/php.ini

WORKDIR /var/www/application
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
