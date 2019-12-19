powerdns
========

Installs a basic PowerDNS authorative server, and enables different backend configurations.

See the full [Salt Formulas installation and usage instructions](http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html).

Usage
=====

All the configuration for powerdns is done via pillar (pillar.example).

Available states
================

`powerdns`
----------

Installs PowerDNS authorative server from official repo, applies configuration.

`powerdns.repo`
---------------

Installs PowerDNS official repostiory.

`powerdns.install`
------------------------

Installs PowerDNS authoritative server, database backend of choice, initializes db backend.

`powerdns.config`
-----------------

Configures PowerDNS authorative server.

`powerdns.api`
--------------

Installes the required pdnsapi python module. Requires pip to work.

To use this module, you need to have the following set either in pillar or your minion config:

```SaltStack

pdns.url: "http://127.0.0.1:8081"
pdns.server_id: "localhost"
pdns.api_key: "deadbeef"
```

