This state will install and configure splunk, if it is not already installed.

**init.sls**: This state contains all of the commands to install splunk. First, it will place the **user-seed.conf** file in splunk's directory, which contains the default username and password.
Second, it will will make sure splunk is installed, and install it if necessary. The installer is located in /srv/salt/files/windows/splunk.
Then, the state will place the deploymentclient.conf file in splunk's directory, which contains the deployment server's information.
After that, it will start splunk if it is not already running. This will only run if the user_seed.conf file is placed and splunk is installed.
Finally, the state will delete the user_seed.conf file, as it contains sensitive password information.

**upgrade.sls** will upgrade Splunk Forwarder. Follow the guide at [Upgrading Splunk Forwarders and Servers](http://wiki.example.com/display/Group/Upgrading+Splunk+Forwarders+and+Servers)

**templates**: This directory contains the following templates: user_seed.conf, deploymentclient.conf