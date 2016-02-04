FROM hub.bccvl.org.au/centos/centos7-epel:2016-02-04

RUN yum install -y python-devel gcc && \
    yum clean all

ENV ZEO_HOME=/opt/zeoserver
ENV ZEO_VAR=/var/opt/zeoserver
ENV ZEO_CONF=/etc/opt/zeoserver

RUN groupadd -g 414 zope && \
    useradd -u 414 -g 414 -d $ZEO_HOME -m -s /bin/bash zope

RUN curl https://bootstrap.pypa.io/get-pip.py | python2.7 && \
    rm -fr ~/.cache

COPY files/requirements.txt $ZEO_HOME/

WORKDIR $ZEO_HOME

RUN pip2.7 install -r requirements.txt && \
    rm -fr ~/.cache

RUN mkdir -p $ZEO_VAR/filestorage

RUN chown -R zope:zope $ZEO_VAR

COPY files/zeoserver.conf $ZEO_CONF/

EXPOSE 8100 8101

# zeoctl takes care of switching user
CMD zeoctl -C $ZEO_CONF/zeoserver.conf start
