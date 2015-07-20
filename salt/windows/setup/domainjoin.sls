# This state will add a computer to prod.example.com, using its current domain name
# This should only be used if the computer name is already changed from the default value
# If this state makes any changes, the machine should be restarted

{% from 'variables.sls' import name with context %}

join machine to domain:
  module.run:
    - name: system.join_domain
    - domain: ad.{{ pillar['domain'] }}
    - username: {{ pillar['domainJoinUser'] }}
    - password: {{ pillar['domainJoinPass'] }}
    - account_ou: 'ou=Servers,dc=prod,dc=example,dc=com'
    - account_exists: False

