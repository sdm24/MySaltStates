# This state will copy over the search head keys onto a splunk indexer
# It uses mine data in  the for loop to get each search head
# This state will also run the splunk/server.sls state, if /opt/splunk does not exist

{% for server, id in salt['mine.get']('search head:True', 'grains.get', expr_form='pillar').items()  %}
copy {{ server }} key:
# Server and id are used in case the minion id does not match the server hostname
  file.managed:
    - name: /opt/splunk/etc/auth/distServerKeys/{{ server }}/trusted.pem
    - source: salt://{{ id }}/opt/splunk/etc/auth/distServerKeys/trusted.pem
    - makedirs: True
    - backup: minion
{% endfor %}

{% if 1 == salt['cmd.retcode']('test -d /opt/splunk') %}
# This tests if splunk is installed, and will run the server.sls state to install splunk if needed
include:
  - .server
{% endif %}
