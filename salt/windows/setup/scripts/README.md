This directory contains the following script:

**domainscript.ps1**: This powershell script will add the computer to ad.example.com with the new computer hostname set in **variables.sls**
This script will not add the computer if the hostname in variables.sls is set to the current name of the computer.
If this script returns errors, then **domainjoin.sls** in /srv/salt can be used to join the computer to AD, using its current name.