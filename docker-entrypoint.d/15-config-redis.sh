#!/bin/bash
set -e

if [ -f "${NEXTCLOUD_REDIS_PASSWORD_FILE}" ]; then
    NEXTCLOUD_REDIS_PASSWORD="$(< "${NEXTCLOUD_REDIS_PASSWORD_FILE}")"
fi

if [ -n "${NEXTCLOUD_REDIS_HOST}" ]; then
    runuser -u www-data -- /bin/sh -c 'cd /var/www/nextcloud; php occ config:system:set \
        redis host --value="${NEXTCLOUD_REDIS_HOST}"'

    runuser -u www-data -- /bin/sh -c 'cd /var/www/nextcloud; php occ config:system:set \
        memcache.distributed --value="\OC\Memcache\Redis"'
    runuser -u www-data -- /bin/sh -c 'cd /var/www/nextcloud; php occ config:system:set \
        memcache.locking --value="\OC\Memcache\Redis"'
    runuser -u www-data -- /bin/sh -c 'cd /var/www/nextcloud; php occ config:system:set \
        memcache.local --value="\OC\Memcache\Redis"'
fi

if [ -n "${NEXTCLOUD_REDIS_PORT}" ]; then
    runuser -u www-data -- /bin/sh -c 'cd /var/www/nextcloud; php occ config:system:set \
        redis port --value="${NEXTCLOUD_REDIS_PORT}"'
fi

if [ -n "${NEXTCLOUD_REDIS_DBINDEX}" ]; then
    runuser -u www-data -- /bin/sh -c 'cd /var/www/nextcloud; php occ config:system:set \
        redis dbindex --value="${NEXTCLOUD_REDIS_DBINDEX}"'
fi

if [ -n "${NEXTCLOUD_REDIS_PASSWORD}" ]; then
    runuser -u www-data -- /bin/sh -c 'cd /var/www/nextcloud; php occ config:system:set \
        redis password --value="${NEXTCLOUD_REDIS_PASSWORD}"'
fi

if [ -n "${NEXTCLOUD_REDIS_TIMEOUT}" ]; then
    runuser -u www-data -- /bin/sh -c 'cd /var/www/nextcloud; php occ config:system:set \
        redis timeout --value="${NEXTCLOUD_REDIS_TIMEOUT}"'
fi

unset NEXTCLOUD_REDIS_PASSWORD

exit 0
