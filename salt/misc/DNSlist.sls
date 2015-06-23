# This state will create a list of current minions not in DNS on the targeted minion(s)
# It will also delete the previous list
# To change the name and path of this file, edit the 'set file' line below

{% set file = '/srv/salt/noDNS' %}

remove old file:
  file.absent:
    - name: {{ file }}

{% for server, hostinfo in salt['mine.get']('*', 'grains.item').items() %}

{% set DNSIP = salt['dnsutil.A'](hostinfo['host'] + ".example.com")[0] %}

{% if DNSIP is not defined %}
{{ hostinfo['host'] }} not in DNS:
  file.append:
    - name: {{ file }}
    - text: {{ hostinfo['host'] }}
    - makedirs: True
{% endif %}

{% endfor %}
