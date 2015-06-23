# This state will restart the targeted minions
# Windows minions will not return a result, but they will restart

{% if grains['kernel'] == 'Linux' %}
restart linux minion:
  cmd.run:
    - name: service salt-minion restart

{% elif grains['kernel'] == 'Windows' %}
restart windows minion:
  cmd.run:
    - name: 'start powershell "Restart-Service -Name salt-minion"'

{% endif %}

