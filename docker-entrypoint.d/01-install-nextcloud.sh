#!/bin/sh
set -e

if [ -d "${NEXTCLOUD_DATA_DIR}" ]; then
if [ -n "${NEXTCLOUD_DATABASE}" ]; then
if [ -n "${NEXTCLOUD_DATABASE_HOST}" ]; then
if [ -n "${NEXTCLOUD_DATABASE_NAME}" ]; then
if [ -n "${NEXTCLOUD_DATABASE_USER}" ]; then
if [ -n "${NEXTCLOUD_DATABASE_PASS}" ]; then
if [ -n "${NEXTCLOUD_ADMIN_USER}" ]; then
if [ -n "${NEXTCLOUD_ADMIN_PASS}" ]; then
    su -s /bin/sh -c 'cd /var/www/nextcloud; php occ maintenance:install \
        --data-dir "${NEXTCLOUD_DATA_DIR}" --database "${NEXTCLOUD_DATABASE}" \
        --database-host "${NEXTCLOUD_DATABASE_HOST}" --database-name "${NEXTCLOUD_DATABASE_NAME}" \
        --database-user "${NEXTCLOUD_DATABASE_USER}" --database-pass "${NEXTCLOUD_DATABASE_PASS}" \
        --admin-user "${NEXTCLOUD_ADMIN_USER}" --admin-pass "${NEXTCLOUD_ADMIN_PASS}"' www-data
fi
fi
fi
fi
fi
fi
fi
fi

exit 0
