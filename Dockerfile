FROM registry.access.redhat.com/rhel7

MAINTAINER author <author@email.com>

RUN groupadd -r mongodb && useradd -r -g mongodb mongodb

RUN subscription-manager register --username "{RHEL_ACCOUNT_USERNAME}"  --password `{RHEL_ACCOUNT_PASSWORD_FILE}` --autosubscribe && \
        yum -y update; yum clean all && \
        yum -y install epel-release; yum clean all && \
        yum -y install mongodb-server; yum clean all && \
        subscription-manager remove --all && \
        subscription-manager unregister

RUN mkdir -p /data/db /data/configdb \
        && chown -R mongodb:mongodb /data/db /data/configdb
VOLUME /data/db /data/configdb

COPY mongo-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 27017
CMD ["mongod"]
