## This state will install and configure mariadb, and create the specified databases from the pillar data
## This state will hang the first time it is run, and must be terminated
## To kill the job: type "salt-run jobs.active" and find the job on the target minion
##  The job id is the header of that specific job, and starts with 2015....
##    then type "salt '*' saltutil.kill_job <job id>"

mariadb-setup:
  debconf.set:
    - name: mariadb-server
    - data:
        'mysql-server/root_password': {'type': 'password', 'value': '{{ pillar['mariadb']['rootpw'] }}'}
        'mysql-server/root_password_again': {'type': 'password', 'value': '{{ pillar['mariadb']['rootpw'] }}'}
    - unless:
      - pkg: mariadb-pkgs

mariadb-pkgs:
  pkg.installed:
    - pkgs:
      - mariadb-server
      - mariadb-client
      - python-mysqldb #required for mysql salt states to function

{% for db, args in pillar['mariadb-dbs'].iteritems() %}
{{ db }}-db:
  mysql_database.present:
    - name: {{ db }}
    - connection_user: root
    - connection_pass: {{ pillar['mariadb']['rootpw'] }}
    - require:
      - pkg: mariadb-pkgs
  mysql_user.present:
    - host: {{ args.get('host', 'localhost') }}
    - name: {{ args['user'] }}
    - password: {{ args['password'] }}
    - connection_user: root
    - connection_pass: {{ pillar['mariadb']['rootpw'] }}
    - require:
      - pkg: mariadb-pkgs
  mysql_grants.present:
    - grant: all privileges
    - database: {{ db }}.*
    - user: {{ args['user'] }}
    - host: {{ args.get('host', 'localhost') }}
    - connection_user: root
    - connection_pass: {{ pillar['mariadb']['rootpw'] }}
    - require:
      - pkg: mariadb-pkgs
{% endfor %}
