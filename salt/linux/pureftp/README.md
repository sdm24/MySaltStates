Pure-ftp is a FTP server. It does not use a standard config file. Instead, multiple one-line files are named with their setting.

**init.sls** will install pure-ftpd, create a ftpgroup group and ftpuser user, and sets the configuration.

**user.sls** will add a virtual user, using the username and password set in the .sls file, to pure-ftpd. If the new user is properly added, the service will restart.

Ex: to add a user named 'example' with password 'p@ssword', edit user.sls so the top lines look like this:
{% set user = 'example %}
{% set password = 'p@ssword' %}

Once the state is run, you can erase the password from user.sls, {% set password = '' %}
