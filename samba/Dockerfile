FROM alpine:latest

RUN apk add --no-cache --update expect krb5 krb5-server pwgen samba samba-dc tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    echo "Asia/Tokyo" > /etc/timezone

COPY entrypoint.sh /entrypoint.sh
COPY krb.expect /krb.expect
ENTRYPOINT [ "/entrypoint.sh" ]