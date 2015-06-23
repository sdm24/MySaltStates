# This state is the main state when setup is run on a new windows VM
# It sets the minion_id in C:\salt\conf\minion, using 1. non-default minion_id in variables.sls
#  2. non-default hostname in variables.sls 3. ID set when salt was installed
# This state will also run network.sls, addomainscript.sls, and cmdcompname.sls when called

{% from 'variables.sls' import name, IP, m_id with context %}

prepend minion file:
  file.prepend:
    - name: c:\salt\conf\minion
    - text: | 
        # This file is managed by Salt!!
        # Any changes will be overwritten!!

replace minion id:
  file.replace:
    - name: c:\salt\conf\minion
    - pattern: '.*id:.*'
{% if m_id == 'desired_minionid' %}
    - repl: 'id: {{ name }}'
{% elif name == 'desired_hostname' %}
    - repl: 'id: {{ grains['id'] }}'
{% else %}
    - repl: 'id: {{ m_id }}'
{% endif %}

Restart Minion:
  cmd.run:
    - name: 'start Powershell "Service-Restart -Name salt-minion"'

include:
  - .network
  - .cmdcompname
  - .adddomainscript
