## This state will run the script-upgrade script, which will upgrade salt-minion on windows machines
## If the minion is using the latest version (the same version as the master), then nothing will happen

{% set servers = '' %}
{% for server, hostinfo in salt['mine.get']('os:Windows', 'grains.item', 'grain').items() %}

{% set minversion = hostinfo['saltversion'] %}

{% if (grains['saltversion'] == minversion) %}
{{ server }} {{ grains['saltversion'] }} same as {{ minversion  }}:
  test.configurable_test_state:
    - name: Version Check
    - changes: False
    - result: True
    - comment: 'Salt-minion is up to date and not upgraded'

{% elif grains['saltversion'] != minversion %}

{% set servers = server~','~servers %}
add {{ server }} to script:
  file.managed:
    - name: /srv/salt/misc/winupgrade/master-script
    - source: salt://misc/winupgrade/master
    - template: jinja
    - context:
        list: {{ servers }}
{% endif %}
{% endfor %}

Minions will be upgraded to {{ grains['saltversion'] }}:
  cmd.script:
    - name: /srv/salt/misc/winupgrade/master-script
    - source: salt://misc/winupgrade/master-script
    - template: jinja
