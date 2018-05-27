#!/bin/sh
set -e

su -s /bin/sh -c 'cd /var/www/nextcloud; php occ maintenance:update:htaccess' www-data

exit 0
