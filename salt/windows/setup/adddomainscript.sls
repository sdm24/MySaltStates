# This state will run the domainscript.ps1 script on a new VM
# The script will join the VM to ad.example.com using its new computer name
# If the computer's name is unchanged, this script will fail, and domainjoin.sls should be run instead
# The computer should be restarted if this state makes any changes

{% from 'variables.sls' import name with context %}

add machine to domain:
  cmd.script:
    - source: salt://setup/scripts/domainscript.ps1
    - shell: powershell
    - template: jinja
    - context: 
        compname: {{ name }}
