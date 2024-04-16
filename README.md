# alpine-mysql
a docker image base on alpine with MySQL/MariaDB

## build image (docker)

```
docker build -t wangxian/alpine-mysql:latest .
```

## build image (docker-compose)

```
cp .env-dist .env
vim build .env # change environment if you need
docker compose build
```

## Usage (docker)

```
# only root user
docker run -it --name mysql -p 3306:3306 -v ~/appdata/mysql:/app/mysql -e MYSQL_DATABASE=admin -e MYSQL_ROOT_PASSWORD=s6321..8 wangxian/alpine-mysql

# use normal user
docker run -it --name mysql -p 3306:3306 -v ~/appdata/mysql:/app/mysql -e MYSQL_DATABASE=admin -e MYSQL_USER=user -e MYSQL_PASSWORD=user123..8 -e MYSQL_ROOT_PASSWORD=s6321..8 wangxian/alpine-mysql
```

## Usage (docker-compose)

```
docker-compose up -d
```


It will:
- set no password for 'root' with localhost connections;
- set password for 'root' with non-localhost connections (default is 's6321..8');
- create a new db (default is 'admin');
- create an user and set his password for non-localhost connections only (defaults are 'user' and 'user123..8').
