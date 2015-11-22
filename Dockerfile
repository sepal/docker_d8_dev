FROM php:5.6-apache
# Created the directory containing the drupal source and the one containing
# files.
RUN mkdir /var/www/html/drupal \
  && mkdir /var/www/html/files

# Drupal should already be cloned into the ./src.
ADD ./src /var/www/html/drupal

# Install some depedencies
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
  && docker-php-ext-install gd mysqli pdo pdo_mysql mbstring opcache \
  && docker-php-ext-enable gd mysqli pdo pdo_mysql mbstring opcache

# Enable mod rewrite
RUN a2enmod rewrite

# Set the correct owner for the files directory.
RUN chown -R www-data:www-data /var/www/html/files
