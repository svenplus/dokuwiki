FROM alpine:latest
RUN apk update && apk add --no-cache \
        php \
        apache2 \
        php-apache2 \
        php-curl \
        php-mbstring \
        php-gd \
        php-session\
        php-exif \
        php-ldap \
        php-pdo \
        php-pdo_mysql \
        php-xml \
        php-iconv \
        unzip \
        && mkdir -p /run/apache2 \
		&& sed -i 's/Options Indexes FollowSymLinks/Options FollowSymLinks/g' /etc/apache2/httpd.conf \
        && echo ServerName 0.0.0.0 >> /etc/apache2/httpd.conf

#Install DoukuWiki
COPY dokuwiki.zip /var/www/localhost/htdocs
RUN cd /var/www/localhost/htdocs && unzip dokuwiki.zip && rm dokuwiki.zip index.html && chmod 777 -R /var/www/localhost/htdocs

#Start Service
EXPOSE 80 443
ENTRYPOINT /usr/sbin/httpd -D FOREGROUND
