FROM mback2k/apache2-php7

MAINTAINER Marc Hoersken "info@marc-hoersken.de"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bzip2 mariadb-client libmariadb2 \
        php7.0-gd php7.0-json php7.0-mysql php7.0-curl php7.0-mbstring \
        php7.0-intl php7.0-mcrypt php-imagick php7.0-xml php7.0-zip \
        php7.0-bz2 php7.0-sqlite3 && \
    apt-get clean

RUN a2enmod rewrite headers env dir mime

RUN mkdir -p /var/www
WORKDIR /var/www

ADD https://download.nextcloud.com/server/releases/latest.tar.bz2 /var/www
RUN tar xfvj latest.tar.bz2
RUN chown root:root -R /var/www/nextcloud

RUN chown www-data:www-data -R /var/www/nextcloud/apps
RUN chown www-data:www-data -R /var/www/nextcloud/config

RUN mkdir -p /var/www/nextcloud/data
RUN chown www-data:www-data -R /var/www/nextcloud/data

VOLUME /var/www/nextcloud/data

ADD docker-websites.d/ /run/docker-websites.d/
