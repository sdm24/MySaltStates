# This state will check the network settings of a minion and make any changes.
# It uses a template for the network settings, and gets the IP address from 1. dig on the hostname 2. current IP from VMware
# When run, this state will include hostupdate.sls and password.sls

{% set name = grains['host'] %}

{% set DNSIP = salt['dnsutil.A'](name + "." + grains['domain'])[0] %}

set network interfaces:
  file.managed:
    - name: /etc/network/interfaces
    - source: salt://linux/networkcheck/templates/interfaces
    - template: jinja
    - defaults:
        Var1: {{ salt['network.interfaces']()['eth0']['inet'][0]['address'] }}
        domname: {{ grains['domain'] }}
{% if DNSIP is defined %}
    - context:
        Var1: {{ DNSIP }}
{% endif %}
    - backup: minion

include:
  - .hostupdate
  - .password
