# alpine-mysql
a docker image base on alpine with mysql

## build image (docker)
```
docker build -t local/wangxian/alpine-mysql:latest .
```
## build image (docker-compose)
```
cp .env-dist .env
nano .env # change environment if you need
docker-compose build
```

## Usage (docker)
```
docker run -it --name mysql -p 3306:3306 -v $(pwd):/app -e MYSQL_DATABASE=admin -e MYSQL_USER=tony -e MYSQL_PASSWORD=dpa\*12d -e MYSQL_ROOT_PASSWORD=111111 local/wangxian/alpine-mysql
```

## Usage (docker-compose)
```
docker-compose up -d
```


It will:
- set no password for 'root' with localhost connections;
- set password for 'root' with non-localhost connections (default is '111111');
- create a new db (default is 'admin');
- create an user and set his password for non-localhost connections only (defaults are 'tony' and 'dpa*12d').
