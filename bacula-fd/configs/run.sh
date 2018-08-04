#!/bin/sh

set -e
set -x

SDCONF="/etc/bacula/bacula-fd.conf"

# Updating owner of directory with configuration files.
chown -R bacula:bacula /etc/bacula

# Updating passwords in configuration files. 
#
# Bacula-fd
sed -i "s/@@FD_PASSWORD@@/$FD_CLIENT1_PASSWORD/g" $SDCONF 
# Bacula-mon-sd
sed -i "s/@@MON_FD_PASSWORD@@/$MON_FD_CLIENT1_PASSWORD/g" $SDCONF 

# Running demon.
cd /etc/bacula/ && bacula-fd -f -u ${BACULA_USER:-bacula} -g ${BACULA_GROUP:-bacula} -c $SDCONF
