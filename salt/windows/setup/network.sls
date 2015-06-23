# This state configures the network settings for a new windows VM
# To configure the IP address, it will try 1. non-default value set in variables.sls
#   2. dig for the computer's hostname 3. current IP address from VMware

{% from 'variables.sls' import name, IP with context %}

{% set DNSIP = salt['dnsutil.A'](name + "example.com")[0] %}

{% set DNSIP2 = salt['dnsutil.A'(name + ".ad.example.com")[0] %}

{% set netname = salt['network.interfaces_names']()[0] %}

Set IP and DNS servers:
  network.managed:
    - name: {{ netname }}
    - dns_proto: static
    - dns_servers:
      - 10.1.1.1
      - 10.1.1.2
    - ip_proto: static
{% if IP != 'desired_IP' %}
    - ip_addrs:
      - {{ IP }}/16
{% elif DNSIP.startswith('1') %}
    - ip_addrs:
      - {{ DNSIP }}/16
{% elif DNSIP2.startswith('1') %}
    - ip_addrs:
      = {{ DNSIP2 }}/16
{% elif IP == 'desired_IP' %}
    - ip_addrs:
      - {{ grains['ipv4'][0] }}/16
{% endif %}
    - gateway: 10.1.0.1

Set DNS Domain:
  win_dns_client.primary_suffix:
    - name: {{ netname }}
    - suffix: ad.example.com
    - updates: False
