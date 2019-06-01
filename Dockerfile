FROM mback2k/apache2-php

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        php7.0-gd php7.0-json php7.0-xml php7.0-mbstring php7.0-zip \
        php7.0-sqlite3 php7.0-mysql php7.0-pgsql \
        php7.0-curl php7.0-bz2 php7.0-intl php7.0-mcrypt \
        php7.0-ldap php7.0-imap php7.0-gmp php7.0-opcache \
        php-redis openssl bzip2 && \
    apt-get install -y --no-install-recommends \
        msmtp msmtp-mta && \
    apt-get clean

RUN a2enmod rewrite headers env setenvif dir mime

RUN mkdir -p /var/www
WORKDIR /var/www

ARG NEXTCLOUD_VERSION=15.0.8

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

ADD opcache-recommended.ini /etc/php/7.0/cli/conf.d/99-opcache-recommended.ini
ADD opcache-recommended.ini /etc/php/7.0/apache2/conf.d/99-opcache-recommended.ini

ENV NEXTCLOUD_DATA_DIR /data
ENV NEXTCLOUD_DATABASE mysql
ENV NEXTCLOUD_DATABASE_HOST mysql
ENV NEXTCLOUD_DATABASE_NAME nextcloud

ADD docker-entrypoint.d/ /run/docker-entrypoint.d/
ADD docker-websites.d/ /run/docker-websites.d/

HEALTHCHECK CMD curl -f http://localhost/cron.php | grep '"status":"success"' || exit 1
