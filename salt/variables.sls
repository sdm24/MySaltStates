# These variables should be changed before you run salt-call

# set the DNS hostname: MANDATORY
{% set name = 'desired_hostname' %}

# set the IP address: optional
# defaults to DNS IP for hostname, or IP from VMWare if DNS IP not found
{% set IP = 'desired_IP' %}

# set the minion id: optional
# defaults to hostname, or hostfile if name is unchanged above
{% set m_id = 'desired_minionid' %}

# set the domain to join: optional
# by default, most machines will be on example.com
{% set domain = 'example.com' %}
