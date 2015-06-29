## This state will set the minions' config file to the minion backup mode
## If any files get changes by Salt via file.manage, file.replace, etc.
##   a backup of the original version will be found in the minion's cache:
##   /var/cache/salt/minion/file_backup for linux machines
##   C:\salt\var\cache\salt\minion\file_backup for windows
## Most states that use file.manage have "backup: minion" set, but this is another failsafe

Set minion backup mode:
  file.append:
{% if grains['kernel'] == 'Linux' %}
    - name: /etc/salt/minion
{% elif grains['kernel'] == 'Windows' %}
    - name: C:\salt\conf\minion
{% endif %}
    - text: 'backup_mode: minion'

Restart minion:
{% if grains['kernel'] == 'Linux' %}
  service.running:
    - name: salt-minion
    - enable: True
{% elif grains['kernel'] == 'Windows' %}
  cmd.wait:
    - name: 'start powershell "Restart-Service -Name salt-minion"'
    - stateful: True
{% endif %}
    - watch:
      - file: 'Set minion backup mode'
