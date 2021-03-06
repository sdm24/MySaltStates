# This file determines what minions run which states
# It is run via the state.highstate command, and scheduled to run every 30 minutes:
# Most server groups are set via pillar information, which can be changed in /srv/pillar/top.sls
# Running highstate will also update the targeted minion's pillar information

# The base environment is /srv/salt
base:
  '*':
    - {{ grains['kernel']|lower }}.networkcheck
 
# The search head and indexer groups are in base because the required keys have their source in salt://(minion-id)
  'services:search head:True':
    - match: pillar
    - linux.splunk.searchhead
  'services:indexer:True':
    - match: pillar
    - linux.splunk.indexer

# The linux environment is /srv/salt/linux
linux:
  'kernel:Linux':
    - match: grain
    - ssh
    - sysstat
    - postfix ## Check unless statements in init.sls file
    - rsyslog
    - keys.minion
    - splunk ## Check unless statements in init.sls file

  'salt':
    - keys.master ## Only generates SSH keys that do not exist

  'services:pureftp:True':
    - match: pillar
    - pureftp

  'services:ntp:True':
    - match: pillar
    - ntp

  'services:apache:True':  ## Only install Apache
    - match: pillar
    - apache
  'services:apache:Managed': ## Manage relevant sites & mods from pillar data
    - match: pillar
    - apache.manage

  'services:mariadb:True':
    - match: pillar
    - mariadb

# The windows environment is /srv/salt/windows
windows:
  'services:splunk:True':
    - match: pillar
    - splunk
 
