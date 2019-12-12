{% from "powerdns/map.jinja" import powerdns with context %}

powerdns-service:
  service.running:
    - name: {{ powerdns.lookup.service }}
    - enable: True
    - require:
      - pkg: powerdns
