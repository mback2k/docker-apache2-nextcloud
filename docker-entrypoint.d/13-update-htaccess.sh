#!/bin/sh
set -e

runuser -u www-data -- /bin/sh -c 'cd /var/www/nextcloud; php occ maintenance:update:htaccess'

exit 0
