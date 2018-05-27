#!/bin/bash

if [ -f "${NEXTCLOUD_DATABASE_PASS_FILE}" ]; then
    NEXTCLOUD_DATABASE_PASS="$(< "${NEXTCLOUD_DATABASE_PASS_FILE}")"
fi

if [ -f "${NEXTCLOUD_ADMIN_PASS_FILE}" ]; then
    NEXTCLOUD_ADMIN_PASS="$(< "${NEXTCLOUD_ADMIN_PASS_FILE}")"
fi

if [ -d "${NEXTCLOUD_DATA_DIR}" ]; then
if [ -n "${NEXTCLOUD_DATABASE}" ]; then
if [ -n "${NEXTCLOUD_DATABASE_HOST}" ]; then
if [ -n "${NEXTCLOUD_DATABASE_NAME}" ]; then
if [ -n "${NEXTCLOUD_DATABASE_USER}" ]; then
if [ -n "${NEXTCLOUD_DATABASE_PASS}" ]; then
if [ -n "${NEXTCLOUD_ADMIN_USER}" ]; then
if [ -n "${NEXTCLOUD_ADMIN_PASS}" ]; then
    runuser -u www-data -- /bin/sh -c 'cd /var/www/nextcloud; php occ status | grep "installed: true"'
    if [ $? -eq 0 ]; then exit 0; fi
    runuser -u www-data -- /bin/sh -c 'cd /var/www/nextcloud; php occ maintenance:install \
        --data-dir "${NEXTCLOUD_DATA_DIR}" --database "${NEXTCLOUD_DATABASE}" \
        --database-host "${NEXTCLOUD_DATABASE_HOST}" --database-name "${NEXTCLOUD_DATABASE_NAME}" \
        --database-user "${NEXTCLOUD_DATABASE_USER}" --database-pass "${NEXTCLOUD_DATABASE_PASS}" \
        --admin-user "${NEXTCLOUD_ADMIN_USER}" --admin-pass "${NEXTCLOUD_ADMIN_PASS}"'
fi
fi
fi
fi
fi
fi
fi
fi

unset NEXTCLOUD_DATABASE_PASS
unset NEXTCLOUD_ADMIN_PASS

exit 0
