#!/bin/sh

set -e
set -x

# Updating owner of directory with configuration files.
chown -R bacula:bacula /etc/bacula

DIRS="  /etc/bacula/bacula-fd.conf 
     "
VARS="  FD_PASSWORD
        MON_FD_PASSWORD 
     "

# Updating variables in configuration files.
for variables in $VARS ; do
  sed -i "s/@@$variables@@/${!variables}/g" ${DIRS}
done

# Running demon.
bacula-fd -f -u bacula -g bacula -c /etc/bacula/bacula-fd.conf 
