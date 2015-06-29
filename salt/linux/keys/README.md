This directory contains two substates, as well as the ssh keys for each linux server.
** To keep old ssh keys for a VM, copy all private and public keys in /etc/ssh on the minion to /srv/salt/linux/keys/servers/<minion hostname>/ on the master**. Otherwise Salt will create new keys and push them to the minion.

**master.sls:** this state should only be run when targeting the master. For each connected linux minion with salt mine data, the state will create new rsa, dsa, ecdsa, and ed25519 keys in a /srv/salt/linux/keys/servers/hostname/ directory.
If a key already exists in that directory, it will be kept.

**minion.sls**: this state should be run on all linux minions. It will grab the keys designated by its hostname and copy them to /etc/ssh/.
If a private key is updated, Salt will not show the changes. However, Salt will show the changes made to public keys.

**servers** contains ssh keys for all of the linux minions connected to the master, organized by minion hostname.
