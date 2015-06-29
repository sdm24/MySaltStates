## This state will change the log format for Salt minion's log
## This way, Splunk can easily organize the logs

Change minions log format:
  file.replace:
{% if grains['kernel'] == 'Linux' %}
    - name: /etc/salt/minion
{% elif grains['os'] == 'Windows' %}
    - name: C:\salt\conf\minion
{% endif %}
    - pattern: .*#log_fmt_logfile:.*
    - repl: >
        log_fmt_logfile: '%(asctime)s,%(msecs)03.0f logger=%(name)s loglevel=%(levelname)s message="%(message)s"'
{% if grains['kernel'] == 'Linux' %}
  service.running:
    - name: salt-minion
    - watch:
      - file: 'Change minions log format'
{% elif grains['os'] == 'Windows' %}
  cmd.wait:
    - name: 'start powershell "Restart-Service -Name salt-minion"'
    - watch:
      - file: 'Change minions log format'
{% endif %}

