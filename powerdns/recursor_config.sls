{% from "powerdns/map.jinja" import pdns_recursor with context %}

powerdns_recursor_config:
  file.managed:
    - name: {{ pdns_recursor.lookup.config_file }}
    - source: salt://powerdns/files/recursor.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - require:
      - pkg: powerdns-recursor
    - watch_in:
      - service: powerdns-recursor
