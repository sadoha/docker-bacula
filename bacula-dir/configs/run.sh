#!/bin/sh

set -e
set -x

# Updating owner of directory with configuration files.
chown -R bacula:bacula /etc/bacula

# Updating passwords in configuration files.
#
# Bacula-dir
sed -i "s/@@DIR_PASSWORD@@/$DIR_PASSWORD/g"             /etc/bacula/*.conf /etc/bacula/conf.d/*.conf /etc/bacula/jobs/*.conf
sed -i "s/@@DIR_MAIL@@/$DIR_MAIL/g"             	/etc/bacula/*.conf /etc/bacula/conf.d/*.conf /etc/bacula/jobs/*.conf
# MySQL
sed -i "s/@@MYSQL_HOST@@/$MYSQL_HOST/g"                 /etc/bacula/*.conf /etc/bacula/conf.d/*.conf /etc/bacula/jobs/*.conf
sed -i "s/@@MYSQL_PORT@@/$MYSQL_PORT/g"                 /etc/bacula/*.conf /etc/bacula/conf.d/*.conf /etc/bacula/jobs/*.conf
sed -i "s/@@MYSQL_DATABASE@@/$MYSQL_DATABASE/g"         /etc/bacula/*.conf /etc/bacula/conf.d/*.conf /etc/bacula/jobs/*.conf
sed -i "s/@@MYSQL_USER@@/$MYSQL_USER/g"                 /etc/bacula/*.conf /etc/bacula/conf.d/*.conf /etc/bacula/jobs/*.conf
sed -i "s/@@MYSQL_PASSWORD@@/$MYSQL_PASSWORD/g"         /etc/bacula/*.conf /etc/bacula/conf.d/*.conf /etc/bacula/jobs/*.conf
# Bacula-fd
sed -i "s/@@FD_PASSWORD@@/$FD_PASSWORD/g"               /etc/bacula/*.conf /etc/bacula/conf.d/*.conf /etc/bacula/jobs/*.conf
sed -i "s/@@MON_FD_PASSWORD@@/$MON_FD_PASSWORD/g"       /etc/bacula/*.conf /etc/bacula/conf.d/*.conf /etc/bacula/jobs/*.conf
sed -i "s/@@FD_CLIENT1_PASSWORD@@/$FD_CLIENT1_PASSWORD/g"       /etc/bacula/*.conf /etc/bacula/conf.d/*.conf /etc/bacula/jobs/*.conf
sed -i "s/@@FD_CLIENT1_HOST@@/$FD_CLIENT1_HOST/g"       /etc/bacula/*.conf /etc/bacula/conf.d/*.conf /etc/bacula/jobs/*.conf
# Bacula-sd
sed -i "s/@@SD_PASSWORD@@/$SD_PASSWORD/g"               /etc/bacula/*.conf /etc/bacula/conf.d/*.conf /etc/bacula/jobs/*.conf
sed -i "s/@@SD_HOST@@/$SD_HOST/g"                       /etc/bacula/*.conf /etc/bacula/conf.d/*.conf /etc/bacula/jobs/*.conf

# Creating Bacula tables in database.
sleep 20
/usr/libexec/bacula/make_mysql_tables $MYSQL_DATABASE -u$MYSQL_USER -p$MYSQL_PASSWORD -h$MYSQL_HOST
sleep 10

# Setting Bacula to use the Mysql library.
echo 1|alternatives --config libbaccats.so

# Running bacula-dir demon.
bacula-dir -f -u bacula -g bacula -c /etc/bacula/bacula-dir.conf & 
sleep 10
bacula-fd  -f -u bacula -g bacula -c /etc/bacula/bacula-fd.conf 
