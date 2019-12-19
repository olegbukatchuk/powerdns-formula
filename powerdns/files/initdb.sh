#!/bin/sh
mysql -u{{ pillar.powerdns.config['gmysql-user'] }} -p'{{ pillar.powerdns.config['gmysql-password'] }}' -h {{ pillar.powerdns.config['gmysql-host'] }} -P {{ pillar.powerdns.config['gmysql-port'] }} {{ pillar.powerdns.config['gmysql-dbname'] }} -e 'select id from records limit 1' >/dev/null 2>&1
rt=$?
if [ $rt -gt 0 ]; then
  echo "Initializing database"
  mysql -u{{ pillar.powerdns.pre['connection-user'] }} -p{{pillar.powerdns.pre['connection-pass']}} {{ pillar.powerdns.config['gmysql-dbname'] }} < /usr/share/doc/pdns-backend-mysql-{{ powerdns.lookup.version }}/schema.mysql.sql
fi
