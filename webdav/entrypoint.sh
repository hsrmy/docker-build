#!/bin/sh
REALM="${REALM:-WebDAV}"

if [ ! -e "/user.passwd" ]; then
    HASH=$(printf '%s' "$USERNAME:$REALM:$PASSWORD"|md5sum|awk '{print $1}')
    echo "$USERNAME:$REALM:$HASH" > /user.passwd
fi

exec "$@"