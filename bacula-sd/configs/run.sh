#!/bin/sh

set -e
set -x

SDCONF="/etc/bacula/bacula-sd.conf"

# Updating owner of directory with configuration files.
chown -R bacula:bacula /etc/bacula

# Updating passwords in configuration files. 
#
# Bacula-sd
sed -i "s/@@SD_PASSWORD@@/$SD_PASSWORD/g" $SDCONF 
# Bacula-mon-sd
sed -i "s/@@MON_SD_PASSWORD@@/$MON_SD_PASSWORD/g" $SDCONF 

# Running bacula-dir demon.
cd /etc/bacula/ && bacula-sd -f -u ${BACULA_USER:-bacula} -g ${BACULA_GROUP:-bacula} -c $SDCONF
