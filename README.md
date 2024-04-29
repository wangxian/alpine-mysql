# alpine-mysql
a very small docker image base on alpine with MySQL/MariaDB

## build local image (docker)

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

# use normal user of app
docker run -it --name mysql -p 3306:3306 -v ~/appdata/mysql:/app/mysql -e MYSQL_DATABASE=admin -e MYSQL_USER=app -e MYSQL_PASSWORD=app123..8 -e MYSQL_ROOT_PASSWORD=s6321..8 wangxian/alpine-mysql
```

## Usage (docker-compose)

```
docker-compose up -d
```


It will:
- set no password for 'root' with localhost connections;
- set password for 'root' with non-localhost connection
- create a new db
- create an normal user and set his password for non-localhost connections
