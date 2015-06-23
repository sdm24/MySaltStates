## This state will install and configure rsyslog
## It will change /etc/rsyslog.conf, /etc/logrotate.d/rsyslog, and /etc/rsyslog.d/50-default.conf
## If the minion name starts with "mail", Salt will use the mail50-default.conf template to manage 50-default.conf
## If any of the files are changed, the rsyslog service will restart

install rsyslog:
  pkg.installed:
    - name: rsyslog

start rsyslog:
# rsyslog will restart if Salt makes any changes to the conf files
  service.running:
    - name: rsyslog
    - enable: True
    - require:
      - pkg: 'install rsyslog'
    - watch:
      - file: 'configure rsyslog.conf'
      - file: 'configure logrotate.d/rsyslog'
      - file: 'configure rsyslog.d/50-default.conf'

configure rsyslog.conf:
  file.managed:
    - name: /etc/rsyslog.conf
    - source: salt://linux/rsyslog/templates/rsyslog.conf
    - backup: minion

configure logrotate.d/rsyslog:
  file.managed:
    - name: /etc/logrotate.d/rsyslog
    - source: salt://linux/rsyslog/templates/logrotatersyslog
    - makedirs: True
    - backup: minion

configure rsyslog.d/50-default.conf:
  file.managed:
    - name: /etc/rsyslog.d/50-default.conf
{% if grains['host'].startswith('mail') %}
# mail and mail1 get special conf files
    - source: salt://linux/rsyslog/templates/mail50-default.conf
{% else %}
    - source: salt://linux/rsyslog/templates/50-default.conf  
{% endif %}
    - makedirs: True
    - backup: minion
