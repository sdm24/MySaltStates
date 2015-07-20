This directory contains the installation files and metadata for the windows repository

It contains the following installers: **Splunk** - Splunk Universal Forwarder v6.2.2-25506
**Salt** - Salt-Minion-2015.5.2-AMD64 

**repo** contains the metadata states for packages that can be installed with the windows repository. Most of these were downloaded from github: https://github.com/saltstack/salt-winrepo
Any sls file without a corresponding installer in salt://files/windows will download its installer online to the minion.
