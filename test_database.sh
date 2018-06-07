#!/bin/bash
set -e -x

if [ "$MYSQL_DATABASE" ]; then
  echo "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}_test\` ;" | "${mysql[@]}"

  if [ "$MYSQL_USER" ]; then
    echo "GRANT ALL ON \`${MYSQL_DATABASE}_test\`.* TO '$MYSQL_USER'@'%' ;" | "${mysql[@]}"
    echo 'FLUSH PRIVILEGES ;' | "${mysql[@]}"
  fi
fi
