FROM php:8.3-apache

WORKDIR /var/www/laravel

RUN apt-get update \
    && apt-get install -y curl apt-transport-https ca-certificates gnupg \
    && apt-get update \
    && apt-get install -y git zip libicu-dev zlib1g-dev g++

RUN docker-php-ext-install pdo pdo_mysql bcmath \
    && docker-php-ext-configure intl && docker-php-ext-install intl

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
    && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite
