This state will install mariadb and create any databases and users defined in the pillar data. Configure databases in /srv/pillar/mariadb, making sure to give them the mariadb-dbs header, and set databases to minions in /srv/pillar/top.sls.

**NOTE**: This state will hang the first time it is run on a minion, including during the highstate when a minion first connects. 
To kill the hung proccess: On the salt master, type *salt-run jobs.active*, and look for the job by matching the function, start time, and target. The header of the job is the job id, and starts with 2015..... Type *"salt '*' saltutil.kill_job [job id]"*, and then rerun the state to configure mariadb
