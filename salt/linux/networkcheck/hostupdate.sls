# This state updates /etc/host, /etc/hostname, and /etc/salt/minion_id on a minion
# If changes are made, the minion will need to reboot

edit hosts file:
  file.managed:
    - name: /etc/hosts
    - source: salt://linux/networkcheck/templates/hosts
    - template: jinja
    - defaults: 
        hname: {{ grains['nodename'] }}
        fqdnIP: {{ grains['fqdn_ip4'][0] }}
        domname: {{ grains['domain'] }}
    - backup: minion

edit hostname file:
  file.managed:
    - name: /etc/hostname
    - source: salt://linux/networkcheck/templates/hostname
    - template: jinja
    - defaults:
        hname: {{ grains['nodename'] }}
    - backup: minion


edit minionid file:
  file.managed:
    - name: /etc/salt/minion_id
    - source: salt://linux/networkcheck/templates/minion_id
    - template: jinja
    - defaults:
        minid: {{ grains['id'] }}
{% if grains['id'] is not defined %}
        minid: {{ grains['nodename'] }}
{% endif %}
    - backup: minion

