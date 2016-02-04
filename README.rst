ZEO Server
==========

This will run ZEO as a standalone servere. It comes with the following list of ZEO scripts installed:

  - zeo-nagios
  - zeoctl
  - zeopack
  - zeopasswd
  - repozo
  - runzeo

Per default ZEO will listen on port 8100 and the ZEO monitor will listen on port 8101

Configuration
-------------

The configuration file for ZEO is stored in /etc/opt/zeoserver/zeoserver.conf.

Data storage
------------

Data is stored in /var/opt/zeoserver .

Build
-----

.. code-block:: Shell

  docker build --rm=true -t hub.bccvl.org.au/zope/zeoserver:4.1.0 .

Publish
-------

.. code-block:: Shell

  docker push hub.bccvl.org.au/zope/zeoserver:4.1.0

