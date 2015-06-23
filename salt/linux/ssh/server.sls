# This state installs openssh-server on a minion and configures it
# The /etc/ssh/sshd_config file is matched to a template stored on the master
# Once everything else has been run, the state will start the ssh service

openssh-server:
  pkg.installed

ssh:
  service.running:
    - require:
      - pkg: openssh-client
      - pkg: openssh-server
      - file: /etc/ssh/sshd_config

/etc/ssh/sshd_config:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://linux/ssh/templates/{{ grains['os'] }}_sshd_config
# Ubuntu and Debian machines have separate server confs
# Ubuntu uses ed25519 keys, while Debian does not
    - require:
      - pkg: openssh-server
    - backup: minion
