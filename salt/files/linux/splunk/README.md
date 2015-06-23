This folder contains the installers for Splunk and Splunkforwarder, as well as symlinks to the most recent version

**NOTE:** To prepare Salt to upgrade to a new version of splunk, delete the old splunk-current.deb and splunkforwarder-current.deb files,
and remake the symlinks to the newest version by typing "ln -s splunk-<new version #s> splunk-current.deb"
and "ln -s splunkforwarder-<new version #s> splunkforwarder-current.deb" when in the /srv/salt/files/linux/splunk directory