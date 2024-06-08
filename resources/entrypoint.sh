#!/bin/sh

set -ex

entrypoint-hooks.sh

migrate-user.sh mysql "$MARIADB_USER_UID"
migrate-group.sh mysql "$MARIADB_GROUP_GID"

if [ ! -d /run/mysqld ]; then
    mkdir -p /run/mysqld; chmod 2775 /run/mysqld; chown mysql:mysql /run/mysqld
fi

if [ ! -d /var/lib/mysql/mysql ]; then
    mariadb-install-db --user=mysql --ldata=/var/lib/mysql
    if [ ! -z "$MARIADB_ROOT_PASSWORD" ]; then
        envsubst < "/usr/local/sql/install.sql" | mariadbd --user=mysql --bootstrap --verbose=0 --skip-name-resolve --skip-networking=0
    fi
fi

entrypoint-post-hooks.sh

exec "$@"
