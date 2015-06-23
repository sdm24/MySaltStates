# This state will add a computer to ad.example.com, using its current domain name
# This should only be used if the computer name is already changed from the default value
# If this state makes any changes, the machine should be restarted

{% from 'variables.sls' import name with context %}

join machine to domain:
  module.run:
    - name: system.join_domain
    - domain: 'ad.example.com'
    - username: 'saltad'
    - password: 'Passw)rd!'
    - account_ou: 'ou=Servers,ou=WORKGROUP,dc=ad,dc=example,dc=com'
    - account_exists: False

