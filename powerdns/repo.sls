{% from "powerdns/map.jinja" import powerdns with context %}

powerdns_server_repo:
  pkgrepo.managed:
    - humanname: PowerDNS
    {% if salt['grains.get']('os_family') == 'Debian' %}
    - name: deb [arch=amd64] https://repo.powerdns.com/{{ salt['grains.get']('os').lower() }} {{ salt['grains.get']('oscodename') }}-auth-{{ powerdns.repo.release }} main
    - file: /etc/apt/sources.list.d/powerdns.list
    - keyid: {{ powerdns.repo.keyid }}
    - keyserver: keys.gnupg.net
    {% elif salt['grains.get']('os_family') == 'RedHat' %}
    - name: powerdns-auth-42
    - humanname: PowerDNS repository for PowerDNS Authoritative Server - version 4.2.X
    - baseurl: http://repo.powerdns.com/{{ salt['grains.get']('os').lower() }}/$basearch/$releasever/auth-42
    #- baseurl: http://repo.powerdns.com/{{ salt['grains.get']('os').lower() }}/{{ salt['grains.get']('osarch') }}/{{ salt['grains.get']('osmajorrelease') }}/auth-42
    - gpgkey: https://repo.powerdns.com/FD380FBB-pub.asc
    - gpgcheck: 1
    - priority: 90
    - includepkg: pdns*
    {% endif %}
