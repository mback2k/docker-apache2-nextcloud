#!/bin/bash
set -e

if [ -n "${NEXTCLOUD_TRUSTED_PROXY}" ]; then
    runuser -u www-data -- /bin/sh -c 'cd /var/www/nextcloud; php occ config:system:set \
        trusted_proxies 1 --value="${NEXTCLOUD_TRUSTED_PROXY}"'
fi

exit 0
