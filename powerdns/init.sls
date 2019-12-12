{% if pillar.powerdns is defined and pillar.powerdns.config is defined %}
include:
 - powerdns.install
 - powerdns.config
 - powerdns.service
{% endif %}
