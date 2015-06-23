# This state installs the openssh client and configures it
# It edits the config file /etc/ssh/ssh_config from a template
# When run, this state includes the server.sls state

openssh-client:
  pkg.installed

include:
  - .server

/etc/ssh/ssh_config:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://linux/ssh/templates/ssh_config
    - require:
      - pkg: openssh-client
    - backup: minion
