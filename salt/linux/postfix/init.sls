## This state will install and configure postfix
## It will configure /etc/postfix/main.cf, /etc/postfix/master.cf,
##   /etc/mailname, and /etc/postfix/aliases
## It will not run on a minion if /opt/zimbra exists, because zimbra uses postfix for the mail servers

install postfix:
  pkg.installed:
    - name: postfix
    - unless: 'test -d /opt/zimbra'
  service.running:
    - name: postfix
    - enable: True
    - require:
      - pkg: postfix
    - watch:
      - file: 'configure main'
    - unless: 'test -d /opt/zimbra'

configure main:
  file.managed:
    - name: /etc/postfix/main.cf
    - source: salt://linux/postfix/templates/{{ grains['os'] }}main.cf
    - template: jinja
    - backup: minion
    - unless: 'test -d /opt/zimbra'
# The templates for main.cf and master.cf differ between the Debian and Ubuntu versions
configure master:
  file.managed:
    - name: /etc/postfix/master.cf
    - source: salt://linux/postfix/templates/{{ grains['os'] }}master.cf
    - template: jinja
    - backup: minion
    - unless: 'test -d /opt/zimbra'

configure mailname:
  file.managed:
    - name: /etc/mailname
    - source: salt://linux/postfix/templates/mailname
    - template: jinja
    - backup: minion
    - unless: 'test -d /opt/zimbra'

configure postfix aliases:
  file.managed:
    - name: /etc/postfix/aliases
    - source: salt://linux/postfix/templates/postfixaliases
    - backup: minion
    - unless: 'test -d /opt/zimbra'

run newaliases:
# This command will refresh the aliases database
  cmd.wait:
    - name: newaliases
    - cwd: /
    - watch:
      - file: /etc/postfix/aliases
    - unless: 'test -d /opt/zimbra'

