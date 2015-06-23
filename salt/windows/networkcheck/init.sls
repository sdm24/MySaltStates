# This state will check the C:\salt\conf\minion configuration file, making sure that the minion ID is correctly set
# If the VM is on a different domain than ad.example.com, this state will print out the VM's name and its domain
# When run, this state will include network

prepend minion:
  file.prepend:
    - name: c:\salt\conf\minion
    - text: | 
        # This file is managed by Salt!!
        # Any changes will be overwritten!!

replace minion:
  file.replace:
    - name: c:\salt\conf\minion
    - pattern: '.*id:.*'
{% if grains['id'] == 'hostname' %}
    - repl: 'id: {{ grains['host'] }}'
{% elif grains['id'] == 'desired_hostname' %}
    - repl: 'id: {{ grains['host'] }}'
{% elif grains['id'] == 'wintemplate' %}
    - repl: 'id: {{ grains['host'] }}'
{% else %}
    - repl: 'id: {{ grains['id'] }}'
{% endif %}

{% if grains['windowsdomain'] != 'ad.example.com' %}
# If a minion is not on ad.example.com, this will print out what domain it is on
check domain:
  module.run:
    - name: cmd.run_stdout
    - cmd: "Get-WmiObject Win32_ComputerSystem | select Name, Domain"
    - shell: powershell
    - python_shell: True
{% endif %}

Restart salt-minion:
  cmd.wait:
    - name: 'start powershell "Restart-Service -Name salt-minion"'
    - watch:
      - file: 'replace minion'
include:
  - .network
