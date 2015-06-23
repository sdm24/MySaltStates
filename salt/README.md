This folder contains the salt states that are on the Salt master.

**top.sls**: This is the main state file that runs other states for different services and servers.

The **linux** directory contains states that are run with linux machines, while the **windows** directory contains states for Windows machines.
See each state directory for more information.

**files** contains linux and windows files and metadata for the windows repository.

**misc** contains msicellaneous states that are not run on the top.sls schedule. Old states will also go here.

**linux/setup** should be downloaded to linux minions to initially set them up. It should not be run once the minion and master are connected.
**windows/setup** should be downloaded for Windows mainions and placed in the c:\salt directory on the minion. It should not be run once the minion and master are connected.

**Variables.sls**: This file contains the variables that are used by linux/setup and windows/setup. They should be changed on the minion server.