# This state sets the /etc/default/sysstat configuration file for sysstat.
# If options should be different than the defaults, change sa1_opts and sa2_opts in the set statements below

{% set sa1_opts = '-S DISK' %}
{% set sa2_opts = '' %}
# -S DISK will generate disk statistics
# sa2_opts will be passed to /etc/cron.daily/sysstat 

sysstat-config:
  file.managed:
    - name: /etc/default/sysstat
    - source: salt://linux/sysstat/templates/sysstat.default
    - mode: 644
    - user: root
    - group: root
    - template: jinja
    - defaults:
        enabled: "true"
        sa1_options: {{ sa1_opts }}
        sa2_options: {{ sa2_opts }}
    - watch_in:
      - service: sysstat
    - require:
      - pkg: sysstat
    - backup: minion
