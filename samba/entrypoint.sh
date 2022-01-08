#!/bin/sh
set -e

SAMBA_DOMAIN=${SAMBA_DOMAIN:-EXAMPLE}
SAMBA_REALM=${SAMBA_REALM:-SAMDOM.EXAMPLE.COM}
SETUP_LOCK_FILE="/tmp/samba.setup.lock"

setup() {
    echo "Initializing ..."

    SAMBA_ADMIN_PASSWORD=${SAMBA_ADMIN_PASSWORD:-$(pwgen -cny 10 1)}
    # 
    export KERBEROS_PASSWORD=${KERBEROS_PASSWORD:-$(pwgen -cny 10 1)}
    echo "Samba administrator password: ${SAMBA_ADMIN_PASSWORD}"
    echo "Kerberos KDC database master key: ${KERBEROS_PASSWORD}"

    rm -rf /etc/samba/smb.conf

    samba-tool domain provision --use-rfc2307 --domain=${SAMBA_DOMAIN} --realm=${SAMBA_REALM} \
        --server-role=dc --dns-backend=SAMBA_INTERNAL --adminpass=${SAMBA_ADMIN_PASSWORD}
    
    cp /var/lib/samba/private/krb5.conf /etc/krb5.conf
    expect krb.expect

    samba-tool domain exportkeytab /etc/krb5.keytab --principal ${HOSTNAME}\$

    touch "${SETUP_LOCK_FILE}"

    echo "Setup finished!"
}

if [ ! -f "${SETUP_LOCK_FILE}" ]; then
    setup
fi

/usr/sbin/krb5kdc -n & 
/usr/sbin/samba -i