This directory contains the salt states that should be run on windows computers.
Refer to each state directory for more information

**setup**: This state should be downloaded to new salt windows machines. It will configure the network and computer name settings. It should not be run from the Salt Master.

**splunk**: This state will install and configure splunk.

**networkcheck**: This state will make sure that the network settings, domain, and minion ID are all properly set.