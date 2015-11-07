FROM alpine:latest
MAINTAINER WangXian <xian366@126.com>

WORKDIR /app
VOLUME /app
ADD startup.sh /startup.sh

RUN apk --update add mysql mysql-client && rm -f /var/cache/apk/* && \
    mkdir -p /app/mysql && \
    mkdir -p /etc/mysql/conf.d && \
    { \
        echo '[mysqld]'; \
        echo 'user = root'; \
        echo 'datadir = /app/mysql'; \
        echo 'port = 3306'; \
        echo 'log-bin = /app/mysql/mysql-bin'; \
        echo '!includedir /etc/mysql/conf.d/'; \
    } > /etc/mysql/my.cnf && \
    rm -rf /app/.git

EXPOSE 3306
CMD ["/startup.sh"]
