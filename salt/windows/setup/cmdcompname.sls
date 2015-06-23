# This state sets the computer name of a new windows VM
# It will set its name from 1. non-default name value in variables.sls 2. The current computer name
# The VM must be rebooted to finalize any changes made by this state

{% from 'variables.sls' import name with context %}

set computer name:
  module.run:
    - name: system.set_computer_name
{% if name != 'desired_hostname' %}
    - m_name: {{ name }}
{% else %}
    - m_name: {{ grains['nodename'] }}
{% endif %}
