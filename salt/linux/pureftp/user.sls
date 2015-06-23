## This substate will add a virtual user to Pure-ftpd
## Set the user and password fields below to match your requirements
## If a new user is created, the Pure-ftpd service will restart
## To hide sensitive information, change the password field back to 'password' after running this state
## If this state is run on web-ftp, it will make the user directory in /var/www/
## Leaving the password field blank ( = '') will make a user with no password

{% set user = 'testuser' %}
{% set password = 'password' %}

Add {{ user }} to pureftp:
  cmd.run:
  {% if grains['id'] == 'web-ftp' %}
    - name: "(echo {{ password }}; echo {{ password }}) | pure-pw useradd {{ user }} -u ftpuser -d /var/www/{{ user }} -m"
  {% else %}
    - name: "(echo {{ password }}; echo {{ password }}) | pure-pw useradd {{ user }} -u ftpuser -d /home/ftpuser/{{ user }} -m"
  {% endif %}
    - unless: 'pure-pw show {{ user }}' 

Create {{ user }} home directory:
  file.directory:
  {% if grains['id'] == 'web-ftp' %}
    - name: /var/www/{{ user }}
  {% else %}
    - name: /home/ftpuser/{{ user }}
  {% endif %}
    - user: ftpuser
    - group: ftpgroup

Create {{ user }} database:
# This command only needs to be run if -m is excluded when adding a user, but no harm in running it again
  cmd.run:
    - name: 'pure-pw mkdb'

Create symlinks:
  cmd.run:
    - name: |
        ln -s /etc/pure-ftpd/pureftpd.passwd /etc/pureftpd.passwd
        ln -s /etc/pure-ftpd/pureftpd.pdb /etc/pureftpd.pdb
        ln -s /etc/pure-ftpd/conf/PureDB /etc/pure-ftpd/auth/PureDB
    - unless: 
      - test -f /etc/pureftpd.passwd
      - test -f /etc/pureftpd.pdb
      - test -f /etc/pure-ftpd/auth/PureDB

{% if grains['id'] == 'web-ftp' %}
Create {{ user }} html folder:
  file.directory:
    - name: /var/www/{{ user }}/html
    - user: ftpuser
    - group: ftpgroup

Create {{ user }} cgi-bin folder:
  file.directory:
    - name: /var/www/{{ user }}/cgi-bin
    - user: ftpuser
    - group: ftpgroup
{% endif %}

Restart pure-ftpd:
  service.running:
    - name: 'pure-ftpd'
    - watch:
      - cmd: 'Add {{ user }} to pureftp'
