# This state installs sysstat and if the OS is Red Hat, makes sure the service is running
# When this state is run, it will also run config.sls that makes sure the configuration file is set correctly

sysstat:
  pkg:
    - installed
    - name: sysstat
  service.running: 
    - enable: True
    - require:
      - pkg: sysstat

include:
  - .config
