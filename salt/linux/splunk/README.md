This state will install and configure splunk forwarder or splunk server, if it is not already installed.

**init.sls**: This state contains all of the commands to install the splunk forwarder. First, it will place the **user-seed.conf** file in splunk's directory, which contains the default username and password.
Second, it will will make sure splunk is installed, and install it if necessary. The installer is located in /srv/salt/lin/files/splunk. If Splunk is already running, the installer will not be moved over.
Then, the state will place the deploymentclient.conf file in splunk's directory, which contains the deployment server's information.
After that, it will start splunk if it is not already running. This will only run if the user_seed.conf file is placed and splunk is installed.
Splunk automatically deletes user-seed.conf as it runs.
This state includes "unless" statements so that it will not run on Splunk servers

**server.sls**: This state installs splunk server. It works identically to init, except that it does not have a user-seed.conf file.
This state is independent of init and needs to manually be called to run: "salt [target minions] state.sls linux.splunk.server". It should only be run on VMs designated as splunk servers

**searchhead.sls:** This state will push the trusted.pem key from a splunk search head to the master, so that it can be later pulled to the indexers.

**indexer.sls:** This state will copy the splunk search head keys onto the indexers. It uses a for loop using salt-mine data to get each search head key

**upgrade.sls:** This state will upgrade the Splunk Forwarder or Splunk server, depending on if /opt/splunk or /opt/splunkforwarder exist. 
Instructions are located at [Upgrading Splunk Forwarders and Servers](http://wiki.example.com/display/Group/Upgrading+Splunk+Forwarders+and+Servers) on the KB

**templates**: This directory contains the following templates: user_seed.conf, deploymentclient.conf