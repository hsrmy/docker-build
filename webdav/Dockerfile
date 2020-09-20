FROM httpd:2.4.46-alpine

COPY ./entrypoint.sh /

RUN mkdir -p /var/lib/dav/data /var/www/html && \
    touch /var/lib/dav/DavLock && \
    chown -R www-data:www-data /var/lib/dav && \
    sed -i -e 's/^#\(LoadModule dav_module.*\)/\1/' conf/httpd.conf && \
    sed -i -e 's/^#\(LoadModule dav_fs_module.*\)/\1/' conf/httpd.conf && \
    sed -i -e 's/^#\(LoadModule auth_digest_module.*\)/\1/' conf/httpd.conf && \
    sed -i -e 's|^#\(Include conf/extra/httpd-autoindex.conf\)|\1|' conf/httpd.conf && \  
    sed -i -e 's/^User .*/User www-data/' conf/httpd.conf && \
    sed -i -e 's/^Group .*/Group www-data/' conf/httpd.conf && \
    sed -i -e 's/^\(IndexOption.*\)/\1 Charset=UTF-8 NameWidth=*/' conf/extra/httpd-autoindex.conf && \
    echo "Include conf/conf-enabled/*.conf" >> conf/httpd.conf && \
    echo "Include conf/sites-enabled/*.conf" >> conf/httpd.conf && \
    mkdir -p conf/conf-available conf/sites-available && \
    ln -s conf-available conf/conf-enabled && \
    ln -s sites-available conf/sites-enabled && \
    chmod +x /entrypoint.sh
RUN apk --update --no-cache add tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    echo "Asia/Tokyo" > /etc/timezone && \
    apk del tzdata
COPY conf/dav.conf ./conf/conf-available/
COPY conf/default.conf ./conf/sites-available/

EXPOSE 80/tcp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["httpd-foreground"]