FROM mysql:5.7.31
LABEL maintainer="Ryan Schlesinger <ryan@outstand.com>"

COPY test_database.sh /docker-entrypoint-initdb.d/test_database.sh
COPY charset.cnf /etc/mysql/conf.d/charset.cnf
