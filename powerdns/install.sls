{% from "powerdns/map.jinja" import powerdns with context %}

{% set os_family = salt['grains.get']('os_family') %}

{% if os_family in ['Debian', 'RedHat'] %}
include:
  - powerdns.repo
{% endif %}

powerdns:
  pkg.installed:
    - name: {{ powerdns.lookup.pkg }}
    - refresh_db: True
    {% if os_family in ['Debian', 'RedHat'] %}
    - require:
      - sls: powerdns.repo
    {% endif %}

{% if 'gmysql' in pillar.powerdns.config.launch %}
powerdns_backend_mysql:
  pkg.installed:
    - name: {{ powerdns.lookup.backend_mysql_pkg }}
    - require:
      - pkg: powerdns

powerdns_mysql_init_db_script:
  file.managed:
    - name: {{ salt.file.dirname(powerdns.lookup.config_file) }}/initdb.sh
    - mode: 700
    - user: root
    - group: root
    - source: salt://powerdns/files/initdb.sh
    - template: jinja

powerdns_mysql_initdb:
  cmd.run:
    - name: {{ salt.file.dirname(powerdns.lookup.config_file) }}/initdb.sh
    - require:
      - file: powerdns_mysql_init_db_script
{% endif %}

{% if 'gsqlite' in pillar.powerdns.config.launch %}
powerdns_backend_sqlite3:
  pkg.installed:
    - name: {{ powerdns.lookup.backend_sqlite3_pkg }}
    - require:
      - pkg: powerdns

#/var/lib/powerdns:
{{ salt.file.dirname(powerdns.config['gsqlite3-database']) }}:
  file.directory:
    - user: pdns
    - group: pdns
    - require:
      - pkg: powerdns_backend_sqlite3

powerdns_init_db:
  cmd.run:
    - name: sqlite3 {{ powerdns.config['gsqlite3-database'] }} < /usr/share/doc/pdns-backend-sqlite3/schema.sqlite3.sql
    - creates: {{ powerdns.config['gsqlite3-database'] }}
    - require:
      - pkg: powerdns_backend_sqlite3
      - file: {{ salt.file.dirname(powerdns.config['gsqlite3-database']) }}

{{ powerdns.config['gsqlite3-database'] }}:
  file.managed:
    - user: pdns
    - group: pdns
    - require:
      - cmd: powerdns_init_db
{% endif %}

