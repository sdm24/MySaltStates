# This file is the main state file for linux setup on a new VM
# It will change the /etc/network/interfaces file from a template
# For the IP address, it will use 1. non-default values in variables.sls, 2. dig of hostname 3. current IP from VMware
# Running this file will include hostupdate.sls and password.sls, and then reset the salt-minion service so the changes will apply

{% from 'variables.sls' import name, IP, domain  with context %}

{% set DNSIP = salt['dnsutil.A'](name + "." + domain)[0] %}

set network interfaces:
  file.managed:
    - name: /etc/network/interfaces
    - source: salt://setup/templates/interfaces
    - template: jinja
    - defaults:
       IPaddr: {{ IP }}
       domname: {{ domain }}
{% if DNSIP is defined %}
    - context:
        IPaddr: {{ DNSIP }}
{% elif IP == 'desired_IP' %}
    - context:
        IPaddr: {{ salt['network.interfaces']()['eth0']['inet'][0]['address'] }}
{% endif %}
    - backup: minion

Restart minion:
  cmd.run:
    - name: 'service salt-minion restart'

include:
  - .hostupdate
  - .password
