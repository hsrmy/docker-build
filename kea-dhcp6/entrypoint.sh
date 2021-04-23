#!/bin/sh

LOCK_FILE="/usr/local/var/run/kea/kea-dhcp6.kea-dhcp6.pid"

if [ -f ${LOCK_FILE} ]; then
    rm -rf ${LOCK_FILE}
fi

exec /usr/local/sbin/kea-dhcp6 -c /etc/kea/kea-dhcp6.conf