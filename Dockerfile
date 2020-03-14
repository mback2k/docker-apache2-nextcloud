FROM mback2k/apache2-php

ARG PHP_VERSION=7.2

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        php${PHP_VERSION}-gd php${PHP_VERSION}-json php${PHP_VERSION}-xml \
        php${PHP_VERSION}-mbstring php${PHP_VERSION}-zip php${PHP_VERSION}-bz2 \
        php${PHP_VERSION}-sqlite3 php${PHP_VERSION}-mysql php${PHP_VERSION}-pgsql \
        php${PHP_VERSION}-curl php${PHP_VERSION}-ldap php${PHP_VERSION}-imap \
        php${PHP_VERSION}-intl php${PHP_VERSION}-gmp php${PHP_VERSION}-opcache \
        php-redis openssl bzip2 && \
    apt-get install -y --no-install-recommends \
        msmtp msmtp-mta && \
    apt-get clean

RUN a2enmod rewrite headers env setenvif dir mime

RUN mkdir -p /var/www
WORKDIR /var/www

ARG NEXTCLOUD_VERSION=16.0.9

ADD https://download.nextcloud.com/server/releases/nextcloud-${NEXTCLOUD_VERSION}.tar.bz2 /var/www
RUN tar xfvj nextcloud-${NEXTCLOUD_VERSION}.tar.bz2

RUN chown root:root -R /var/www/nextcloud
RUN chown www-data:www-data /var/www/nextcloud/.htaccess

RUN chown www-data:www-data -R /var/www/nextcloud/config
VOLUME /var/www/nextcloud/config

RUN mkdir -p /var/www/nextcloud/custom_apps
RUN chown www-data:www-data -R /var/www/nextcloud/custom_apps
VOLUME /var/www/nextcloud/custom_apps

RUN mkdir -p /data
RUN chown www-data:www-data -R /data
VOLUME /data

ADD opcache-recommended.ini /etc/php/${PHP_VERSION}/cli/conf.d/99-opcache-recommended.ini
ADD opcache-recommended.ini /etc/php/${PHP_VERSION}/apache2/conf.d/99-opcache-recommended.ini

ENV NEXTCLOUD_DATA_DIR /data
ENV NEXTCLOUD_DATABASE mysql
ENV NEXTCLOUD_DATABASE_HOST mysql
ENV NEXTCLOUD_DATABASE_NAME nextcloud

ADD docker-entrypoint.d/ /run/docker-entrypoint.d/
ADD docker-websites.d/ /run/docker-websites.d/

HEALTHCHECK CMD curl -f http://localhost/cron.php | grep '"status":"success"' || killall -0 run-parts || exit 1
