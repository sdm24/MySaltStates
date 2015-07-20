# This state makes sure a minion's network settings are correct
# For the IP address, the state will use the IP from 1. a dig of the VM hostname 2. value set in VMware

{% set netname = salt['network.interfaces_names']()[0] %}

{% set name = grains['host'] %}

{% set DNSIP = salt['dnsutil.A'](name + "." + grains['domain'])[0] %}

Set IP and DNS servers:
  network.managed:
    - name: {{ netname }}
    - dns_proto: static
    - dns_servers:
      - 10.1.24.50
      - 10.1.24.51
    - ip_proto: static
{% if DNSIP != 'U' %}
    - ip_addrs:
      - {{ DNSIP }}/16
{% else %}
    - ip_addrs:
      - {{grains['ipv4'][0] }}/16
{% endif %}
    - gateway: 10.1.0.1

Set DNS Domain:
  win_dns_client.primary_suffix:
    - name: {{ netname }}
    - suffix: prod.{{ pillar['domain'] }}
    - updates: False
