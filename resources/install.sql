FLUSH PRIVILEGES;
DROP DATABASE IF EXISTS `test`;
DELETE FROM `mysql`.`user` WHERE `User` != 'root';
DELETE FROM `mysql`.`proxies_priv` WHERE `User` != 'root';
GRANT ALL ON *.* TO 'root'@'%' identified by '${MARIADB_ROOT_PASSWORD}' WITH GRANT OPTION;
GRANT ALL ON *.* TO 'root'@'localhost' identified by '${MARIADB_ROOT_PASSWORD}' WITH GRANT OPTION;
FLUSH PRIVILEGES;
