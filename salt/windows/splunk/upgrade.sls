# This state will upgrade Splunk Forwarder for Windows minions
# The installer and repo settings are located in /srv/salt/files/windows
# It will only run if Splunk is already installed at C:\Program Files\SplunkUniversalForwarder\

Splunk:
  pkg.installed:
    - onlyif: dir "C:\Program Files\SplunkUniversalForwarder\"

start splunk:
  cmd.run:
    - name: ' "C:\Program Files\SplunkUniversalForwarder\bin\splunk.exe" restart'
    - require:
      - pkg: Splunk
    - onlyif: dir "C:\Program Files\SplunkUniversalForwarder\" 
