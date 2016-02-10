FROM hub.bccvl.org.au/centos/centos7-epel:2016-02-04

RUN yum install -y python-devel gcc rsync && \
    yum clean all

ENV SETUPTOOLS 20.0
ENV ZCBUILDOUT 2.5.0
ENV ZEO_HOME=/opt/zeoserver
ENV ZEO_VAR=/var/opt/zeoserver
ENV ZEO_CONF=/etc/opt/zeoserver

RUN groupadd -g 414 zope && \
    useradd -u 414 -g 414 -d $ZEO_HOME -m -s /bin/bash zope

COPY files/buildout.cfg \
     files/bootstrap-buildout.py \
     $ZEO_HOME/

WORKDIR $ZEO_HOME

RUN python2.7 bootstrap-buildout.py --buildout-version=$ZCBUILDOUT --setuptools-version=$SETUPTOOLS && \
    ./bin/buildout

RUN mkdir -p $ZEO_CONF && \
    chown -R zope:zope $ZEO_VAR && \
    chown -R zope:zope $ZEO_CONF

EXPOSE 8100 8101

# zeoctl takes care of switching user
CMD ./bin/zeoserver fg
