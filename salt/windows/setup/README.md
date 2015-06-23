This directory contains the setup state, which should be run on a windows machine with salt-minion installed.

When this directory is pulled to the machine, move this directory and its contents to C:\Salt or whereever the main Salt directory is.

See http://wiki.example.com/display/Group/Setting+Up+a+New+VM+with+Salt for instructions on how to use this state

**IMPORTANT:** In order to use salt-call on windows minions, change the minion conf file to set "c:\salt" as the base for file_root.
I will change the conf file here to reflect this change

**init.sls**: this is the main state file. When "C:\salt\salt-call ... setup" is run, this will edit the minion file in C:\salt\conf\minion.
This file will change the id of the minion to the "m_id" value set in **variables.sls**, or to the value for "name" if m_id is unchanged.
It will also add comments to the top of the file, saying that the file is managed by Salt.

**network.sls**: This is the state file that will update the network settings on the Windows machine. It will set the DNS servers to 10.1.24.50 and 10.1.24.51, gateway to 10.1.0.1, subnet mask to 255.255.255.0, and set the IP address.
The IP address will be set with this priority: 1. manually-set "IP" value in **variables.sls** 2. IP from querying 'hostname' 3. IP set by VMware
This state can be run on its own without windows.setup with "C:\salt\salt-call ... setup.network"

**cmdcompname.sls**: This state file will rename the Windows computer. The name will be set as the "name" value in **variables.sls**.
If the default name is not changed, then the computer will be renamed to the nodename grain.

**adddomainscript.sls**: This state file will run the **domainscript.ps1** powershell script, which will add the computer to ad.example.com with a new computer name.
This new name uses the hostname set in **variables.sls**. This allows a computer to join AD with the correct name, without requiring a restart.
This state will fail if the variables hostname is the same as the current computer name.

**domainjoin.sls**: This state will join a windows machine to ad.example.com, using its current computer name. This will be the case when an older machine was configured before salt was installed.
This state should only be run if adddomainscript fails. It can be updated by running "C:\salt\salt-call ... setup.domainjoin"

**scripts**: This directory contains the domainscript.ps1 script