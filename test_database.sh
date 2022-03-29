#!/bin/bash

set -eo pipefail

create_database() {
  name="$1"

  mysql_note "Creating database ${name}"
  docker_process_sql --database=mysql <<<"CREATE DATABASE IF NOT EXISTS \`${name}\` ;"

  if [ -n "${MYSQL_USER:-}" ]; then
    mysql_note "Giving user ${MYSQL_USER} access to schema ${name}"
    docker_process_sql --database=mysql <<<"GRANT ALL ON \`${name}\`.* TO '${MYSQL_USER}'@'%' ;"
    docker_process_sql --database=mysql <<<"FLUSH PRIVILEGES ;"
  fi
}

if [ -n "${MYSQL_DATABASES:-}" ]; then
  IFS=',' read -ra databases <<< "$MYSQL_DATABASES"

  for name in "${databases[@]}"; do
    create_database "${name}"
    create_database "${name}_test"
  done
fi
