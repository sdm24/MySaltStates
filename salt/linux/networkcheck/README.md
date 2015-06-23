This folder contains the "networkcheck" state files and templates used to make sure that settings configured when setup were ran were not changed.

**init.sls**: This is the main state file that will run when networkcheck is called.

**hostupdate.sls**: This is the state file that will check /etc/hosts, /etc/hostname, and /etc/salt/minion_id.

**templates** contains the following templates: etc/network/interfaces, etc/hosts, etc/hostname, and /etc/salt/minion_id