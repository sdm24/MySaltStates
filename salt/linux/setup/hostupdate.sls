# This state will edit/create the /etc/hosts, /etc/hostname, and /etc/salt/minion_id files on a new VM
# It uses templates with variables to match each file.
# If variable.sls is unedited, salt will use current server settings for hostname, domain, and minion_id

{% from 'variables.sls' import m_id, name, domain with context %}

set hosts file:
  file.managed:
    - name: /etc/hosts
    - source: salt://setup/templates/hosts
    - template: jinja
    - defaults: 
        hname: {{ name }}
        fqdnIP: {{ grains['fqdn_ip4'][0] }}
        domname: {{ domain }}
{% if name == 'desired_hostname' %}
    - context:
        hname: {{ grains['nodename'] }}
{% endif %}
    - backup: minion

set hostname file:
  file.managed:
    - name: /etc/hostname
    - source: salt://setup/templates/hostname
    - template: jinja
    - defaults:
        hname: {{ name }}
{% if name == 'desired_hostname' %}
    - context:
        hname: {{ grains['nodename'] }}
{% endif %}
    - backup: minion

set minionid file:
  file.managed:
    - name: /etc/salt/minion_id
    - source: salt://setup/templates/minion_id
    - template: jinja
    - defaults:
        minid: {{ m_id }}
{% if name == 'desired_hostname' %}
    - context:
        minid: {{ grains['nodename'] }}
{% elif m_id == 'desired_minionid' %}
    - context:
        minid: {{ name }}
{% endif %}
    - backup: minion
