This state wil upgrade windows salt-minions to the current version. See [Advanced Salt Topics](http://wiki.example.com/display/SALT/Advanced+Salt+Topics) for the required steps

**init.sls**  will add any un-upgraded windows minions to a list in **master-script** using master as a template, then runs master-script which calls **script-upgrade** on the master, which will run upgrade-minion on the minions. 
**Upgrade-minion** will install salt-minion, and start the service. 

**Removeold.sls** is a state file that will delete depreciated files, and should be run only after minions using version 2014.7.2 are upgraded.

**to upgrade salt-minion on windows**: make sure that the latest salt-minion .exe is in /srv/salt/files/windows/salt and symlinked to Salt-Current.exe. Run the state with *salt 'salt' state.sls misc.winupgrade*. 
Once the state finishes in about 90 seconds, check the comments for the last step (it will time out in the middle).  
Finally, run *salt -G 'os:windows' state.sls misc.repofix*, and repeat for misc.logchange and misc.backupfix to change the minion's conf settings.
