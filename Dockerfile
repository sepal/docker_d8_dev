FROM ubuntu:14.04

# persistent / runtime deps
RUN apt-get update && apt-get install -y ca-certificates curl librecode0 \
  libsqlite3-0 libxml2 --no-install-recommends python-software-properties \
  software-properties-common

# Add custom ppa repository to get php5.6, we need to set the language
# correctly for that, otherwise add-apt-repository will throw an error.
RUN export LANG=C.UTF-8 && add-apt-repository -y ppa:ondrej/php5-5.6 && apt-get update

# Install php and nginx + some additional packages.
RUN apt-get install -y php5-fpm php5-cli php5-mysql php-apc php5-curl php5-gd \
  php5-intl php5-mcrypt php5-memcache php5-sqlite php5-tidy php5-xmlrpc \
  php5-xsl php5-pgsql php5-mongo php5-xdebug \
  nginx openssh-server supervisor vim less pwgen

# Clean up.
RUN rm -r /var/lib/apt/lists/*

# Configure nginx.
RUN rm -Rf /etc/nginx/conf.d/* && \
  rm -Rf /etc/nginx/sites-available/default
COPY ./config/nginx-drupal.conf /etc/nginx/sites-available/drupal.conf
RUN ln -s /etc/nginx/sites-available/drupal.conf \
  /etc/nginx/sites-enabled/drupal.conf

# Configure php for drupal development environment.
COPY ./config/php.ini /etc/php5/fpm/php.ini
COPY ./config/xdebug.ini /etc/php5/mods-available/xdebug.ini
RUN echo "clear_env = no" >> /etc/php5/fpm/pool.d/www.conf

# Copy several configs.
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Created the directory containing the drupal source and the one containing
# files.
RUN mkdir -p /var/www/drupal /var/www/files

# Drupal should already be cloned into the ./src.
ADD ./src /var/www/

# Add the custom drupal settings file.
COPY config/settings.php /var/www/sites/default/settings.php

# Generate a hash salt, which the settins.php will include.
RUN pwgen -s 30 1 > /tmp/salt.txt

# Enable opcache and mbstring.
RUN php5enmod mbstring opcache

# Set the correct owner for the files directory.
RUN chown -R www-data:www-data /var/www/

CMD ["/usr/bin/supervisord"]
