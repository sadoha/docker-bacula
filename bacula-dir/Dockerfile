FROM centos:centos7

MAINTAINER Andrii Sadovskyi, andrii.sadovskyi@gmail.com

ADD configs/epel-bacula7.repo /etc/yum.repos.d/epel-bacula7.repo

RUN yum -y install --setopt=tsflags=nodocs epel-release && \ 
    yum -y install mariadb bacula-director-mysql bacula-console bacula-client mysql-devel net-tools vim && \ 
    yum -y update && yum clean all

# Copying  Bacula-dir run file.
ADD configs/run.sh /run.sh
RUN chmod 755 /run.sh && chown root:root /run.sh

# Copying mysqldump script file.
ADD scripts/mysqldump.sh /mysqldump.sh
RUN chmod 755 /mysqldump.sh && chown root:root /mysqldump.sh

# Copying bacula-dir config file.
ADD configs/bacula-dir.conf /etc/bacula/bacula-dir.conf

# Copying bacula config files.
RUN mkdir /etc/bacula/conf.d/
ADD configs/storages.conf /etc/bacula/conf.d/storages.conf
ADD configs/pools.conf /etc/bacula/conf.d/pools.conf

# Copying job files.
RUN mkdir /etc/bacula/jobs/
ADD jobs/* /etc/bacula/jobs/

EXPOSE 9101

ENTRYPOINT ["/run.sh"]
