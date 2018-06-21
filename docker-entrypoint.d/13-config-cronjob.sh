#!/bin/sh
set -e

runuser -u www-data -- /bin/sh -c 'cd /var/www/nextcloud; php occ config:app:set core backgroundjobs_mode --value="webcron"'

exit 0
