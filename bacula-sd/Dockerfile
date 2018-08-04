FROM centos:centos7

MAINTAINER Andrii Sadovskyi, andrii.sadovskyi@gmail.com

ADD configs/epel-bacula7.repo /etc/yum.repos.d/epel-bacula7.repo

RUN yum -y install --setopt=tsflags=nodocs epel-release && \ 
    yum -y install bacula-storage-mysql net-tools vim && \ 
    yum -y update && yum clean all

# Copying  Bacula-sd run file.
ADD configs/run.sh /run.sh
RUN chmod 755 /run.sh && chown root:root /run.sh

EXPOSE 9103

ENTRYPOINT ["/run.sh"]
