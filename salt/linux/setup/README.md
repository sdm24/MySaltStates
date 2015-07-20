This folder contains the "setup" state file and templates

see http://wiki.example.com/display/SALT/Setting+Up+a+New+VM+with+Salt for instructions on how to use this state

**init.sls**: This is the main file that is needed to run "salt-call ... setup". It will configure the IP address of the minion and also run "hostupdate", which will configure the hostname.
This scipt will set the IP of the machine using this priority: 1. Manually editing the "IP" value in **variables.sls** 2. Result from dig hostname 3. IP set automatically in VMware

**hostupdate.sls**: This is the state file that will configure /etc/hosts, /etc/hostname, and /etc/salt/minion_id. It is run automaticcaly when setup is run, or can be run on its own with "salt-call ... setup.hostupdate"
Currrently, this is identical to DefaultToNodeName.sls. This means that if "name" in **variables.sls** is not updated, the script will use the default hostname on the server.

**password.sls**: This state file will change the root computer name in /etc/passwd to the hostname of the computer.

DefaultToNodeName.sls: This file is a state template that can be used for hostupdate.sls. Simply rename this file to hostupdate.sls to do this.
This state will use the pre-set hostname of the server, if "name" is kept as the default 'desired_hostname' value in the variables.sls file
This is currently being used for hostupdate.sls

NoDefaultName.sls: This file is a state template that can be used for hostupdate.sls. Simply rename this file to hostupdate.sls to do this.
This state will use 'desired_hostname' as the hostname for the server, if "name" is kept as the default 'desired_hostname' value in the variables.sls file

**templates**: This folder contains the template files that salt will manage: host, hostname, minion_id, and interfaces