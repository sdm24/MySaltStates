# This state will edit /etc/passwd and change the root name to the computer hostname

{% from 'variables.sls' import name with context %}

prepend passwd:
  file.prepend:
    - name: /etc/passwd
    - text: |
       # This file is managed by Salt!!
       # Any changes to the "root" line  will be overwritten!!

replace passwd:
  file.replace:
    - name: /etc/passwd
    - pattern: root:x:0:0:root:/root:/bin/bash
{% if name != 'desired_hostname' %}
    - repl: 'root:x:0:0:{{ name|upper }}:/root:/bin/bash'
{% else %}
    - repl: 'root:x:0:0:{{ grains['nodename']|upper }}:/root:/bin/bash'
{% endif %}
