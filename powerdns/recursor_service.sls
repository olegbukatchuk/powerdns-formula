{% from "powerdns/map.jinja" import pdns_recursor with context %}

powerdns-recursor-service:
  service.running:
    - name: {{ pdns_recursor.lookup.service }}
    - enable: True
    - require:
      - pkg: powerdns-recursor
