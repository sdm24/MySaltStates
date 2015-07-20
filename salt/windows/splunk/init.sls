# This state installs and configures the Splunk Universal Forwarder for windows
# The installer and repo settings are located in /srv/salt/files/windows

user_seed:
  file.managed:
    - name: 'C:\Program Files\SplunkUniversalForwarder\etc\system\local\user-seed.conf'
    - source: salt://windows/splunk/templates/userseed.conf
    - makedirs: True
	- template: jinja

Splunk:
  pkg.installed:
    - unless: DIR "C:\Program Files\SplunkUniversalForwarder\bin\splunk.exe"

deploy_client:
  file.managed:
    - name: 'C:\Program Files\SplunkUniversalForwarder\etc\system\local\deploymentclient.conf'
    - source: salt://windows/splunk/templates/deploymentclient.conf
    - makedirs: True
    - backup: minion
	- template: jinja

start splunk:
  cmd.run:
    - name: ' "C:\Program Files\SplunkUniversalForwarder\bin\splunk.exe" start'
    - require:
      - pkg: Splunk
      - file: user_seed

delete user_seed:
# User seed must be manually deleted for windows forwarders
  file.absent:
    - name: 'C:\Program Files\SplunkUniversalForwarder\etc\system\local\user-seed.conf'
    - require:
      - cmd: 'start splunk'
