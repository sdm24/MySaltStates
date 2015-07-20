This directory contains states that are not scheduled to run in the highstate. They must be manually called.

**DNSlist.sls** will create a list of server hostnames that are not on the DNS nameserver. The path and name for this list can be changed in the state file.

**chocolatey**: This state will install chocolatey. It also contains substates that will install packages. It should only be run on Windows minions.
It contains the substates **vim** to install vim

**repofix.sls** sets the directory for the win_repo cache on Windows minions to the correct filepath, then restarts the minion so the changes are made.
This state should be run if a Windows machine returns errors when installing Splunk or some other program from the windows repository.

**restart.sls** will restart the salt-minion service on the targeted minions, for both Linux and Windows machines. 
When this state is called, Linux machines will return that they are restarting, while Windows machines will time out. Both OSes will restart the salt-minion service.

**npp.sls** installs Notepad++ from the Windows repo in files/windows/repo

**logchange.sls** formats the salt minion logs so Splunk can read them

**backupfix.sls** sets the minion's backup mode, so any files changed by Salt are backed up in the minion's cache

**password.sls** changes the root password to the value set in the pass field, or a manually generated hash. To generate a hash: run the following command:
*python -c "import crypt; print crypt.crypt('newpass', '\$6\SALTsalt')"*, replacing newpass with the password you want, then copy the hash value in the "password:" key under user.present.
NOTE: when manually generating the hash, special characters (#,$,!, etc.) cannot be used. They can be used in the 'pass' field in the state

**winupgrade**: this state will upgrade any out-of-date windows minions when called. It is run targeting the Salt master *salt 'salt' state.sls misc.winupgrade*

**resolvfix**: updates /etc/resolv.conf to include prod.example.com as a search domain, if the configured domain is example.com

**pkgupgrade**: updates the repo and upgrades any out-of-date packages on the targeted linux minions
