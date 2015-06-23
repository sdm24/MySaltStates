# This state will install the splunk server
# The install .deb file is saved in srv/salt/lin/files/splunk on the master
# The install file is copied into the /tmp directory, and that file is ran on the minion

Remove Splunk forwarder:
# The forwarder cannot run on Splunk Servers
  cmd.run:
    - name: 'dpkg -r splunkforwarder'
    - onlyif: 'dpkg -s splunkforwarder'

Make user_seed:
  file.managed:
    - name: '/opt/splunk/etc/system/local/user-seed.conf'
    - source: salt://linux/splunk/templates/userseed.conf
    - makedirs: True
 
Splunk Server:
  cmd.run:
    - name: 'dpkg -i /tmp/splunk-current.deb'
    - unless: 'dpkg -s splunk'
    - require:
      - file: 'Server installer'

Server installer:
  file.managed:
    - name: /tmp/splunk-current.deb 
    - source: salt://files/linux/splunk/splunk-current.deb
    - unless: 'dpkg -s splunk'

Server deployment_client:
  file.managed:
    - name: '/opt/splunk/etc/system/local/deploymentclient.conf'
    - source: salt://linux/splunk/templates/deploymentclient.conf
    - makedirs: True
    - backup: minion

start splunk Server:
  cmd.run:
    - name: '/opt/splunk/bin/splunk start --accept-license --answer-yes'
    - unless: 'service splunk status'
    - require:
      - cmd: 'Splunk Server'

enable server bootstart:
  cmd.run:
    - name: '/opt/splunk/bin/splunk enable boot-start'
    - require:
      - cmd: 'start splunk Server'

set SplunkHome:
  cmd.run:
    - name: 'export SPLUNK_HOME=/opt/splunk'

install snmp:
# Allows splunk to poll over snmp
  pkg.installed:
    - pkgs:
      - snmp
      - snmp-mibs-downloader

touch ui_login:
# This file makes Splunk believe that you have logged in before
  file.managed:
    - name: '/opt/splunk/etc/.ui_login'
    - backup: minion
