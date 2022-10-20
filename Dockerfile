# Note: This file is only for development purpose only.
ARG PHP_VERSION=8.0
ARG COMPOSER_VERSION=2.2
ARG PHP_EXT_INSTALLER_VERSION=1.5

FROM composer:$COMPOSER_VERSION AS composer

FROM mlocati/php-extension-installer:$PHP_EXT_INSTALLER_VERSION AS ext-installer

FROM php:$PHP_VERSION-fpm-alpine

LABEL Maintainer="Ishan Vyas <isvyas@gmail.com>"

COPY --from=ext-installer /usr/bin/install-php-extensions /usr/bin/

RUN chmod +x /usr/bin/install-php-extensions && \
    install-php-extensions intl mysqli pdo_mysql

# Use the default development configuration
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN mkdir -p /.composer

USER www-data:www-data

COPY --chown=www-data:www-data . /var/www/html

WORKDIR /var/www/html

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN composer install --no-ansi --no-interaction

ENV PATH="${PATH}:/home/www-data/.composer/vendor/bin"

EXPOSE 9000
