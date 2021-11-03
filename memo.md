apk update
apk add tzdata
cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
mysql
SHOW VARIABLES LIKE '%time_zone%';
