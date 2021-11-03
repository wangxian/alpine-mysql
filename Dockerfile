FROM alpine:3.14 as builder
MAINTAINER WangXian <xian366@126.com>

RUN apk update && apk add tzdata

FROM alpine:3.14

COPY --from=builder /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

WORKDIR /app
VOLUME /app

RUN apk add --update mysql mysql-client && rm -f /var/cache/apk/*

# These lines moved to the end allow us to rebuild image quickly after only these files were modified.
COPY ./conf/startup.sh /startup.sh
COPY ./conf/my.cnf /etc/mysql/my.cnf

EXPOSE 3306
CMD ["/startup.sh"]
