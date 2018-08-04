#!/bin/sh

mysqldump $MYSQL_DATABASE -u$MYSQL_USER -p$MYSQL_PASSWORD -h$MYSQL_HOST > /etc/bacula/$MYSQL_DATABASE.dump
