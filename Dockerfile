FROM php:8.1-bullseye

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get -y --no-install-recommends --fix-missing install \
    git \
    libzip-dev \
    zip \
    unzip

# Install php modulues
RUN docker-php-ext-install -j "$(nproc)" \
  zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENV COMPOSER_ALLOW_SUPERUSER=1
RUN composer global config --no-plugins allow-plugins.dealerdirect/phpcodesniffer-composer-installer true
RUN composer global require drupal/coder dealerdirect/phpcodesniffer-composer-installer -n
# Fix for 8.3.14 https://gorannikolovski.com/blog/referenced-sniff-slevomat-coding-standard-does-not-exist
RUN composer global update --with-dependencies drupal/coder

COPY ./docker-entrypoint.sh /bin/docker-entrypoint
RUN chmod +x /bin/docker-entrypoint

ENTRYPOINT [ "docker-entrypoint" ]
USER root
WORKDIR /app
