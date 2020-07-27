#!/bin/sh

exec /usr/sbin/kea-dhcp4 -c /etc/kea/kea-dhcp4.conf
exec /usr/sbin/kea-dhcp6 -c /etc/kea/kea-dhcp6.conf