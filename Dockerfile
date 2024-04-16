FROM alpine:3.16
MAINTAINER WangXian <xian366@126.com>

WORKDIR /app
# VOLUME /app

RUN apk add --update mysql mysql-client && rm -f /var/cache/apk/*
COPY my.cnf /etc/mysql/my.cnf
COPY startup.sh .

EXPOSE 3306
CMD ["/bin/sh", "/app/startup.sh"]
