{% from "powerdns/map.jinja" import pdns_recursor with context %}

{% set os_family = salt['grains.get']('os_family') %}

{% if os_family in ['Debian', 'RedHat'] %}
include:
  - powerdns.recursor_repo
{% endif %}

powerdns-recursor:
  pkg.installed:
    - name: {{ pdns_recursor.lookup.pkg }}
    - refresh_db: True
    {% if os_family in ['Debian', 'RedHat'] %}
    - require:
      - sls: powerdns.recursor_repo
    {% endif %}



