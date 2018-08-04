#!/bin/sh

set -e
set -x

# Updating owner of directory with configuration files.
chown -R bacula:bacula /etc/bacula

DIRS="  /etc/bacula/bacula-sd.conf
     "
VARS="  SD_PASSWORD
        MON_SD_PASSWORD
     "

# Updating variables in configuration files.
for variables in $VARS ; do
  sed -i "s/@@$variables@@/${!variables}/g" ${DIRS}
done

# Running bacula-dir demon.
bacula-sd -f -u bacula -g bacula -c /etc/bacula/bacula-sd.conf 
