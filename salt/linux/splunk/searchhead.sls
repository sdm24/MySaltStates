# This state pulls the splunk search head key and saves them in the master's cache
# Once saved, they will be pushed out to the splunk indexers
# This file will include the splunk server state, if it is not already installed

pull search head keys:
  module.run:
    - name: cp.push
    - path: /opt/splunk/etc/auth/distServerKeys/trusted.pem

{% if 1 == salt['cmd.retcode']('test -d /opt/splunk') %}
# This will test if splunk is installed, and run the server.sls state to install Splunk if needed
include:
  - .server
{% endif %}
