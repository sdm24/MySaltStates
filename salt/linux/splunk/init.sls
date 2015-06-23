# This state file installs the splunk universal forwarder, sets the deployment configuration,
#   and will have the forwarder run on startup
# The install .deb file is saved in srv/salt/lin/files/splunk on the master
# The install file is copied into the /tmp directory, and that file is ran on the minion
# This state should not run anything for Splunk servers!


user_seed:
  file.managed:
    - name: '/opt/splunkforwarder/etc/system/local/user-seed.conf'
    - source: salt://linux/splunk/templates/userseed.conf
    - makedirs: True
{% if grains['id'].startswith('splunk') %}
    - unless: 'test -d /opt/splunk'
{% else%}
    - unless: 'dpkg -s splunkforwarder'
{% endif %}

Splunk:
  cmd.run:
    - name: 'dpkg -i /tmp/splunkforwarder-current.deb'
    - require:
      - file: installer
{% if grains['id'].startswith('splunk') %}
    - unless: 'test -d /opt/splunk'
{% else%}
    - unless: 'dpkg -s splunkforwarder'
{% endif %}


installer:
  file.managed:
    - name: /tmp/splunkforwarder-current.deb 
    - source: salt://files/linux/splunk/splunkforwarder-current.deb
{% if grains['id'].startswith('splunk') %}
    - unless: 'test -d /opt/splunk'
{% else%}
    - unless: 'dpkg -s splunkforwarder'
{% endif %}


deployment_client:
  file.managed:
    - name: '/opt/splunkforwarder/etc/system/local/deploymentclient.conf'
    - source: salt://linux/splunk/templates/deploymentclient.conf
    - makedirs: True
    - backup: minion
    - unless: 'test -d /opt/splunk'

start splunk:
  cmd.run:
    - name: '/opt/splunkforwarder/bin/splunk start --accept-license --answer-yes --no-prompt'
    - require:
      - cmd: Splunk
      - file: user_seed
{% if grains['id'].startswith('splunk') %}
    - unless: 'test -d /opt/splunk'
{% else%}
    - unless: 'service splunk status'
{% endif %}


enable bootstart:
  cmd.run:
    - name: '/opt/splunkforwarder/bin/splunk enable boot-start'
    - require:
      - cmd: 'start splunk'
    - unless: 'test -d /opt/splunk'
