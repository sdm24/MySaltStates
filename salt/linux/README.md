This directory contains the salt states that should be run on linux computers. Refer to each state directory for more information

**setup**: This state should be downloaded to new linux machines. It will configure the network and hostname settings. It should not be run from the Salt Master.

**networkcheck**: This state will check that the settings from setup are set correctly, and will overwrite any changes not made by Salt.

**keys:** This state has 2 substates. 'master' should be run targeting the salt master, and it will generate SSH keys for each linux minion and store them. 'minion' will copy the keys on the master to the minion's /etc/ssh directory
IF YOU WANT TO SAVE EXISTING SSH KEYS FOR A MINION: copy the keys located in /etc/ssh on the minion to /srv/salt/linux/keys/server/[hostname]/ on the master, where hostname is the minion's hostname.

**splunk**: This contains states to install and configure splunk forwarder and splunk server. The forwarder is installed with the default init.sls file, while the server must be called manually.
This directory also contains state files for splunk search heads to copy their keys to the salt master and splunk indexers to receive those files.

**ssh:** This state installs and configures openssh-client and openssh-server. Both are installed when the ssh state is ran in salt.

**postfix:** This state installs and configures postfix mail client. Any email sent to a linux VM will be sent to errors@example.com instead.

**sysstat:** This installs and configures sysstat.

**rsyslog:** Installs and configures rsyslog

**pureftp:** This state installs and configures Pure-ftp. It contains a 'user' substate to add a virtual user, which must be manually called.

**ntp:** This state installs and configures ntp server. It should only be run on ntp3 and ntp4

**apache:** Installs apache, and manages sites & mods if set in the pillar. The manage substate should be included in the scheduled highstate to manage the apache sites and mods enabled. See [Managing Apache With Salt] (http://wiki.example.com/display/SALT/Managing+Apache+With+Salt) on the KB

**mariadb**: Installs mariadb and creates any databases defined in the pillar data. This state will hang when it is first run, and must be manually killed. See its README for more info.
