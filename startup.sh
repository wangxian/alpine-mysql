#!/bin/bash

set -eo pipefail
shopt -s nullglob

if [ ! -d "/run/mysqld" ]; then
  mkdir -p /run/mysqld
  chown -R mysql:mysql /run/mysqld
  chmod 777 /run/mysqld 
else  
  rm -f /run/mysqld/msqld.sock
fi

if [ -d /data/mysql ]; then
  echo "[i] MySQL directory already present, skipping creation"
else
  echo "[i] MySQL data directory not found, creating initial DBs"

  #mysql_install_db --user=root > /dev/null
  mysql_install_db > /dev/null

  if [ "${MYSQL_ROOT_PASSWORD}" = "" ]; then
    MYSQL_ROOT_PASSWORD="111111"
    echo "[i] MySQL root Password: $MYSQL_ROOT_PASSWORD"
  fi

  MYSQL_DATABASE=${MYSQL_DATABASE:-""}
  MYSQL_USER=${MYSQL_USER:-""}
  MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}

  tfile=`mktemp`
                                                                                                                                        
  if [ ! -f "$tfile" ]; then
    return 1
  fi

  cat << EOF > $tfile
USE mysql;
DELETE FROM mysql.user;
CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;
EOF

  if [ "$MYSQL_DATABASE" != "" ]; then
    echo "[i] Creating database: $MYSQL_DATABASE"
    echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile

    if [ "$MYSQL_USER" != "" ]; then
      echo "[i] Creating user: $MYSQL_USER with password $MYSQL_PASSWORD"
      echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
      echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%';" >> $tfile
    fi
  fi

  # /usr/bin/mysqld --user=root --bootstrap < $tfile

  /usr/bin/mysqld --skip-networking &
  pid="$!"

  mysql=( mysql --protocol=socket -uroot -hlocalhost --socket=/run/mysqld/mysqld.sock )

  for i in {30..0}; do
    if echo 'SELECT 1' | "${mysql[@]}" &> /dev/null; then
       break
    fi

    echo 'MySQL init process in progress...'
    sleep 1
  done

  if [ "$i" = 0 ]; then
     echo >&2 'MySQL init process failed.'
     exit 1
  fi

  "${mysql[@]}" < $tfile

  rm -f $tfile

  if ! kill -s TERM "$pid" || ! wait "$pid"; then
     echo >&2 'MySQL init process failed.'
     exit 1
  fi
fi

#exec /usr/bin/mysqld --user=root --console

exec /usr/bin/mysqld
