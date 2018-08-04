FROM centos:centos7

MAINTAINER Andrii Sadovskyi, andrii.sadovskyi@gmail.com

RUN yum -y install --setopt=tsflags=nodocs epel-release && \ 
    yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum-config-manager --enable remi-php56 && \
    yum -y install httpd wget tar && \
    yum -y install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo php-gettext php-posix && \
    yum -y update && yum clean all

RUN wget -q http://www.bacula-web.org/files/bacula-web.org/downloads/bacula-web-latest.tgz && \
    mkdir -v /var/www/html/bacula-web && \
    tar -xzf bacula-web-latest.tgz -C /var/www/html/bacula-web && \
    rm -rf /var/www/html/bacula-web-latest.tgz 
     
ADD run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
