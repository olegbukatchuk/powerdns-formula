{% from "powerdns/map.jinja" import pdns_recursor with context %}

powerdns_resolver_repo:
  pkgrepo.managed:
    - humanname: PowerDNS resolver
    {% if salt['grains.get']('os_family') == 'Debian' %}
    - name: deb [arch=amd64] https://repo.powerdns.com/{{ salt['grains.get']('os').lower() }} {{ salt['grains.get']('oscodename') }}-res-{{ pdns_recursor.repo.release }} main
    - file: /etc/apt/sources.list.d/powerdns_res.list
    - keyid: {{ powerdns.repo.keyid }}
    - keyserver: keys.gnupg.net
    {% elif salt['grains.get']('os_family') == 'RedHat' %}
    - name: powerdns-rec-43
    - humanname: PowerDNS repository for PowerDNS Recursor - version 4.3.X
    - baseurl: http://repo.powerdns.com/{{ salt['grains.get']('os').lower() }}/$basearch/$releasever/rec-43
    #- baseurl: http://repo.powerdns.com/{{ salt['grains.get']('os').lower() }}/{{ salt['grains.get']('osarch') }}/{{ salt['grains.get']('osmajorrelease') }}/rec-{{ pdns_recursor.repo.release }}
    - gpgkey: https://repo.powerdns.com/FD380FBB-pub.asc
    - gpgcheck: 1
    - priority: 90
    - includepkg: pdns*
    {% endif %}
