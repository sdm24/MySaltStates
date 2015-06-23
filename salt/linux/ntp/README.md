NTP (Network Time Protocol) will install and configure ntp server. This will allow ntp3 and ntp4 to synchronize the dates on the client machines.


**init.sls** is the main state file that will install ntp and configure /etc/ntp.conf. If any changes are made to the conf file, the service will restart.

**templates** contains 2 templates for /etc/ntp.conf for the servers, 1ntp.conf and 2ntp.conf
