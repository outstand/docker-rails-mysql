#!/bin/bash
set -e

if [ -n "$MYSQL_DATABASE" ]; then
  mysql_note "Creating database ${MYSQL_DATABASE}_test"
  docker_process_sql --database=mysql <<<"CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}_test\` ;"

  if [ -n "$MYSQL_USER" ]; then
    mysql_note "Giving user ${MYSQL_USER} access to schema ${MYSQL_DATABASE}_test"
    docker_process_sql --database=mysql <<<"GRANT ALL ON \`${MYSQL_DATABASE}_test\`.* TO '$MYSQL_USER'@'%' ;"
    docker_process_sql --database=mysql <<<"FLUSH PRIVILEGES ;"
  fi
fi
