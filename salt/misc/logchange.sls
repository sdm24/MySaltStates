## This state will change the log format for Salt minion's log
## This way, Splunk can easily organize the logs
## It should only be run on Linux minions

Change minions log format:
  file.replace:
    - name: /etc/salt/minion
    - pattern: .*log_fmt_logfile:.*
    - repl: >
        log_fmt_logfile: '%(asctime)s,%(msecs)03.0f logger=%(name)s loglevel=%(levelname)s message="%(message)s"'
  service.running:
    - name: salt-minion
    - watch:
      - file: 'Change minions log format'
