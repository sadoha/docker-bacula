#!/bin/sh

set -e
set -x

# Updating owner of directory with configuration files.
chown -R bacula:bacula /etc/bacula

DIRS="	/etc/bacula/*.conf
	/etc/bacula/conf.d/*.conf
	/etc/bacula/jobs/*.conf
     "
VARS="	DIR_PASSWORD
	DIR_MAIL
	MYSQL_HOST
	MYSQL_PORT
	MYSQL_DATABASE
	MYSQL_USER
	MYSQL_PASSWORD
	FD_PASSWORD
	MON_FD_PASSWORD
	FD_CLIENT1_PASSWORD
	FD_CLIENT1_HOST
	SD_PASSWORD
	SD_HOST
     "

# Updating variables in configuration files.
for variables in $VARS ; do
  sed -i "s/@@$variables@@/${!variables}/g" ${DIRS}
done

# Creating Bacula tables in database.
sleep 30
/usr/libexec/bacula/make_mysql_tables $MYSQL_DATABASE -u$MYSQL_USER -p$MYSQL_PASSWORD -h$MYSQL_HOST

# Setting Bacula to use the Mysql library.
echo 1|alternatives --config libbaccats.so
sleep 10

# Running bacula-dir demon.
bacula-dir -f -u bacula -g bacula -c /etc/bacula/bacula-dir.conf &
bacula-fd  -f -u bacula -g bacula -c /etc/bacula/bacula-fd.conf
