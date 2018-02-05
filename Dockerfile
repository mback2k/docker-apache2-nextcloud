FROM mback2k/apache2-php

MAINTAINER Marc Hoersken "info@marc-hoersken.de"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        php7.0-gd php7.0-json php7.0-xml php7.0-mbstring php7.0-zip \
        php7.0-sqlite3 php7.0-mysql php7.0-pgsql \
        php7.0-curl php7.0-bz2 php7.0-intl php7.0-mcrypt \
        php7.0-ldap php7.0-imap php7.0-gmp \
        bzip2 && \
    apt-get clean

RUN a2enmod rewrite headers env dir mime

RUN mkdir -p /var/www
WORKDIR /var/www

ARG NEXTCLOUD_VERSION=12.0.5

ADD https://download.nextcloud.com/server/releases/nextcloud-${NEXTCLOUD_VERSION}.tar.bz2 /var/www
RUN tar xfvj nextcloud-${NEXTCLOUD_VERSION}.tar.bz2
RUN chown root:root -R /var/www/nextcloud

RUN chown www-data:www-data -R /var/www/nextcloud/apps
RUN chown www-data:www-data -R /var/www/nextcloud/config

RUN mkdir -p /var/www/nextcloud/data
RUN chown www-data:www-data -R /var/www/nextcloud/data

VOLUME /var/www/nextcloud/data

ADD docker-websites.d/ /run/docker-websites.d/
