## This state will upgrade the Splunk server and Splunk Forwarder on Linux minions
## It will check to see which version it will upgrade
## Make sure that the symlinks for splunk-current.deb and splunkforwarder-current.deb are up-to-date

Copy Server installer:
  file.managed:
    - name: /tmp/splunk-current.deb 
    - source: salt://files/linux/splunk/splunk-current.deb
    - onlyif: 'test -d /opt/splunk'

Update Splunk server:
  cmd.run:
    - name: 'dpkg -i /tmp/splunk-current.deb'
    - onlyif: 'test -d /opt/splunk/'

Restart Splunk server:
  cmd.run:
    - name: '/opt/splunk/bin/splunk start --accept-license --answer-yes'
    - unless: 'service splunk status'
    - require:
      - cmd: 'Update Splunk server'
    - onlyif: 'test -d /opt/splunk'

Copy Forwarder installer:
  file.managed:
    - name: /tmp/splunkforwarder-current.deb 
    - source: salt://files/linux/splunk/splunkforwarder-current.deb
    - onlyif: 'test -d /opt/splunkforwarder'

Update Splunk Forwarder:
  cmd.run:
    - name: 'dpkg -i /tmp/splunkforwarder-current.deb'
    - onlyif: 'test -d /opt/splunkforwarder'

Start Splunk forwarder:
  cmd.run:
    - name: '/opt/splunkforwarder/bin/splunk start --accept-license --answer-yes --no-prompt'
    - unless: 'service splunk status'
    - require:
      - cmd: 'Update Splunk Forwarder'
    - onlyif: 'test -d /opt/splunkforwarder'
