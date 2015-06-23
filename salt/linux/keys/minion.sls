## This state will copy SSH keys from the master to the minion
## It will place the keys in /etc/ssh on the minion and only copy keys that change
## The changes made to private keys will not be shown, but changes to public keys will


{% for type in 'dsa','ecdsa','ed25519','rsa' %}

copy {{ type }} ssh key:
  file.managed:
    - name: /etc/ssh/ssh_host_{{ type }}_key
    - source: salt://linux/keys/servers/{{ grains['host'] }}/ssh_host_{{ type }}_key
    - makedirs: True
    - show_diff: False
    - backup: minion
copy {{ type }} pub key:
  file.managed:
    - name: /etc/ssh/ssh_host_{{ type }}_key.pub
    - source: salt://linux/keys/servers/{{ grains['host'] }}/ssh_host_{{ type }}_key.pub
    - makedirs: True
    - show_diff: True
    - backup: minion
{% endfor %}
