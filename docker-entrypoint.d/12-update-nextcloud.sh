#!/bin/sh
set -e

runuser -u www-data -- /bin/sh -c 'cd /var/www/nextcloud; php occ upgrade'

runuser -u www-data -- /bin/sh -c 'cd /var/www/nextcloud; php occ db:add-missing-indices'

exit 0
