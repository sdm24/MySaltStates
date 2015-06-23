## This state should be run on the salt master ("salt 'salt' state.sls linux.keys.master")
## It will generate SSH keys for each linux minion, storing the keys in /srv/salt/linux/keys/servers/<hostname>
## If keys are manually copied into the directory, this state will not generate new keys

{% for server, hostinfo in salt['mine.get']('kernel:Linux', 'grains.item', expr_form='grain').items() %}

create {{ hostinfo['host'] }} directory:
  file.directory:
    - name: /srv/salt/linux/keys/servers/{{ hostinfo['host'] }}
    - makedirs: True

{% for type in 'dsa','ecdsa','ed25519','rsa' %}

create {{ type }} key for {{ hostinfo['host'] }}:
  cmd.run:
    - name: |
        ssh-keygen -q -t {{ type }} -N '' -f /srv/salt/linux/keys/servers/{{ hostinfo['host'] }}/ssh_host_{{ type }}_key -C 'root@{{ hostinfo['host'] }} Created by Salt'
        echo 'y'
    - unless: test -f /srv/salt/linux/keys/servers/{{ hostinfo['host'] }}/ssh_host_{{ type}}_key
{% endfor %}
{% endfor %}
