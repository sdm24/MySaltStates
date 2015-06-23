These are the files that will install and configure sysstat. They will be run with "salt [target minions] state.sls linux.sysstat"

**init.sls:** This will install sysstat from apt

**config.sls:** This will set the configuration based on the sysstat.default template. sa1_options refers to options passed to sa1. sa2_options refers to options passed to sa2.