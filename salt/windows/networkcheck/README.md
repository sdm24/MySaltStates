This directory contains the networkcheck state, which checks that windows machines are configured correctly.

**init.sls**: this is the main state file. It will check the minion config file to make sure that the minion ID is set correctly. It will also check the domain the machine is on, and will print out the domain name if it is not ad.example.com.

**network.sls**: This is the state file that will check the network settings. It will set the DNS servers to 10.1.1.1 and 10.1.1.2, gateway to 10.1.0.1, subnet mask to 255.255.255.0, and set the IP address.
The IP address will be set with this priority: 1. IP from querying 'hostname' 2. Current IP
