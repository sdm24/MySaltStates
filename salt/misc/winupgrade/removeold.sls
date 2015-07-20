{% for file in 'salt-call.exe','salt-cp.exe','salt-minion.exe','salt-unity.exe','salt-2014.7.2.win-amd64','upgrade.exe','upgrade-minion.cmd' %}
Remove {{ file }}:
  file.absent:
  - name: C:\salt\{{ file }}
{% endfor %}

