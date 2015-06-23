# This state will edit the /etc/passwd file on a minion
# It will change the root name to the computer hostname

prepend passwd:
  file.prepend:
    - name: /etc/passwd
    - text: |
       # This file is managed by Salt!!
       # Changes made to the "root" line  will be overwritten!!

replace passwd:
  file.replace:
    - name: /etc/passwd
    - pattern: root:x:0:0:root:/root:/bin/bash
    - repl: 'root:x:0:0:{{ grains['nodename']|upper }}:/root:/bin/bash'
    - backup: minion
