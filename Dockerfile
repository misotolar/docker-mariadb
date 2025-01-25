FROM misotolar/alpine:3.21.2

LABEL maintainer="michal@sotolar.com"

ENV MARIADB_VERSION=11.4.4
ENV MARIADB_INSTALL=11.4.4-r1

ENV MARIADB_USER_UID=100
ENV MARIADB_GROUP_GID=101

RUN set -ex; \
    apk add --no-cache \
        gettext-envsubst \
        mariadb="$MARIADB_INSTALL" \
        mariadb-client="$MARIADB_INSTALL" \
        mariadb-server-utils="$MARIADB_INSTALL" \
    ; \
    rm -rf \
        /var/cache/apk/* \
        /var/tmp/* \
        /tmp/*

COPY resources/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY resources/install.sql /usr/local/sql/install.sql

EXPOSE 3306
VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["entrypoint.sh"]
CMD ["mariadbd", "--user=mysql", "--console", "--skip-name-resolve", "--skip-networking=0"]
