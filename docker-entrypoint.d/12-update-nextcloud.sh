#!/bin/sh
set -e

runuser -u www-data -- /bin/sh -c 'cd /var/www/nextcloud; php occ upgrade'

exit 0
