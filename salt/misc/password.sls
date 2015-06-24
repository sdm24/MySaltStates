## This state will change the root password on linux minions
## It will automatically generate a password hash for whatever value is set for 'pass'
## Special characters, such as $ or !, will be passed through and hashed properly
## To manually generate a password hash, run this command:
##   python -c "import crypt; print crypt.crypt('password', '\$6\$SALTsalt\$')"
##     where 'password' is the desired password (keep the single quotes)
##       and copy that hash into the 'password' key below, replacing the double brackets at the bottom of the file
## Once this state is run, you can set 'pass' to something generic to hide your confidential password
## NOTE: The plain-text password will be logged if the master or minion loglevel is set to INFO or DEBUG

{% set pass = "te$t!ng" %}
{% set import = "import crypt; print crypt.crypt('" + pass + "', '\$6\$SALTsalt')" %}
# the import variable is needed because the python command mixes single quotes and double quotes

Change root password:
  user.present:
    - name: root
    - password: {{ salt['cmd.run']('python -c "'+ import +'"') }}
