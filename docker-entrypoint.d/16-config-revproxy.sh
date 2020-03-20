#!/bin/bash
set -e

if [ -n "${NEXTCLOUD_TRUSTED_PROXY}" ]; then
    runuser -u www-data -- /bin/sh -c 'cd /var/www/nextcloud; php occ config:system:set \
        trusted_proxies 1 --value="${NEXTCLOUD_TRUSTED_PROXY}"'
fi

if [ -n "${NEXTCLOUD_OVERWRITE_HOST}" ]; then
    runuser -u www-data -- /bin/sh -c 'cd /var/www/nextcloud; php occ config:system:set \
        overwritehost --value="${NEXTCLOUD_OVERWRITE_HOST}"'
fi

if [ -n "${NEXTCLOUD_OVERWRITE_PROTOCOL}" ]; then
    runuser -u www-data -- /bin/sh -c 'cd /var/www/nextcloud; php occ config:system:set \
        overwriteprotocol --value="${NEXTCLOUD_OVERWRITE_PROTOCOL}"'
fi

exit 0
