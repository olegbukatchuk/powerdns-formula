{% if pillar.powerdns is defined or pillar['powerdns-recursor'] is defined %}
include:
{% if pillar.powerdns is defined and pillar.powerdns.config is defined %}
 #- powerdns.install
 - powerdns.config
 - powerdns.service
{% endif %}
{% if pillar['powerdns-recursor'] is defined and pillar['powerdns-recursor']['config'] is defined %}
 - powerdns.recursor
 - powerdns.recursor_config
 - powerdns.recursor_service
{% endif %}
{% endif %}
