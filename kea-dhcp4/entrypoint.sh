#!/bin/sh

LOCK_FILE="/usr/local/var/run/kea/kea-dhcp4.kea-dhcp4.pid"

if [ -f ${LOCK_FILE} ]; then
    rm -rf ${LOCK_FILE}
fi

exec /usr/local/sbin/kea-dhcp4 -c /etc/kea/kea-dhcp4.conf