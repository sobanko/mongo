FROM registry.access.redhat.com/rhel7

MAINTAINER author <author@email.com>

RUN groupadd -r mongodb && useradd -r -g mongodb mongodb

RUN subscription-manager register --username "{RHEL_ACCOUNT_USERNAME}"  --password `{RHEL_ACCOUNT_PASSWORD_FILE}` --autosubscribe
 
RUN yum -y update; yum clean all 
RUN yum -y install epel-release; yum clean all 
RUN yum -y install mongodb-server; yum clean all 
RUN subscription-manager remove --all 
RUN subscription-manager unregister

COPY config/mongodb.conf /mongodb.conf

COPY config/mongodb /etc/logrotate.d/mongodb

RUN chmod +x /etc/logrotate.d/mongodb

RUN chown mongodb:mongodb /etc/logrotate.d/mongodb

RUN mkdir -p /data/db /data/configdb
RUN chown -R mongodb:mongodb /data/db /data/configdb

VOLUME /data/db /data/configdb

COPY mongo-entrypoint.sh /mongo-entrypoint.sh
RUN chmod +x /mongo-entrypoint.sh

EXPOSE 27017

CMD ["/mongo-entrypoint.sh"]



