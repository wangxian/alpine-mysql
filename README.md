# alpine-mysql
a docker image base on alpine with mysql

# build image
```
docker build -t wangxian/alpine-mysql .
docker run -it --rm -v $(pwd):/app -p 3306:3306 wangxian/alpine-mysql
```