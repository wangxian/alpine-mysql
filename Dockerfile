FROM alpine:3.4

MAINTAINER WangXian <xian366@126.com>

WORKDIR /data

COPY startup.sh /startup.sh

RUN apk add --no-cache bash mysql mysql-client \
    && rm -rf /var/cache/apk/*

COPY my.cnf /etc/mysql/my.cnf

EXPOSE 3306

CMD ["/startup.sh"]
